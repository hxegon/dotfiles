#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-}"
OS="$(uname)"
[ "$OS" = "Darwin" ] && OS_BUCKET="macos" || OS_BUCKET="linux"

ALL_BUCKETS=(core macos linux opt opt-macos opt-linux)

desc() {
    local file="$1/.description"
    [ -f "$file" ] && cat "$file"
}

stow_pkg() {
    local bucket_dir="$1" flag="$2" pkg="$3"
    echo "  $pkg"
    local extra_ignores=()
    local ignore_file="$bucket_dir/$pkg/.stowignore"
    if [ -f "$ignore_file" ]; then
        while IFS= read -r line; do
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "$line" ]] && continue
            extra_ignores+=("--ignore=$line")
        done < "$ignore_file"
    fi
    if [ "$flag" = "--adopt" ]; then
        stow --no-folding --ignore='\.description' --ignore='\.stowignore' "${extra_ignores[@]}" --adopt -d "$bucket_dir" -t "$HOME" "$pkg" 2>/dev/null || \
            stow --no-folding --ignore='\.description' --ignore='\.stowignore' "${extra_ignores[@]}" --override='.*' -d "$bucket_dir" -t "$HOME" "$pkg"
    else
        stow --no-folding --ignore='\.description' --ignore='\.stowignore' "${extra_ignores[@]}" $flag -d "$bucket_dir" -t "$HOME" "$pkg"
    fi
}

stow_dir() {
    local bucket_dir="$1" flag="$2"; shift 2 || true
    if [ $# -gt 0 ]; then
        for pkg in "$@"; do
            [ -d "$bucket_dir/$pkg" ] || { echo "  $pkg: not found in $bucket_dir"; continue; }
            stow_pkg "$bucket_dir" "$flag" "$pkg"
        done
    else
        for dir in "$bucket_dir"/*/; do
            [ -d "$dir" ] || continue
            stow_pkg "$bucket_dir" "$flag" "$(basename "$dir")"
        done
    fi
}

# stow named pkgs, each from the first listed bucket that contains it
stow_pkgs_from() {
    local flag="$1"; shift
    local -a buckets=()
    while [ "$1" != "--" ]; do buckets+=("$1"); shift; done
    shift  # drop the --
    for pkg in "$@"; do
        local found=0
        for bucket in "${buckets[@]}"; do
            [ -d "sources/$bucket/$pkg" ] || continue
            stow_pkg "sources/$bucket" "$flag" "$pkg"
            found=1
            break
        done
        if [ "$found" -eq 0 ]; then echo "  $pkg: not found in ${buckets[*]}"; fi
    done
}

cleanup_stale() {
    echo "Cleaning up stale symlinks..."
    local count=0
    while IFS= read -r link; do
        [ -z "$link" ] && continue
        local target; target="$(readlink "$link")"
        case "$target" in
            *dotfiles/sources/*|*dotfiles/bin/*)
                # -e follows the link, so a resolving target (relative or absolute) is kept
                [ -e "$link" ] && continue
                echo "  removing: $link"
                rm -f "$link"
                count=$((count + 1))
                ;;
        esac
    done < <(find "$HOME" -maxdepth 5 -type l 2>/dev/null)
    if [ "$count" -gt 0 ]; then echo "  removed $count stale symlinks"; fi
}

is_stowed() {
    local bucket_dir="$1" pkg="$2"
    while IFS= read -r -d '' src; do
        local rel="${src#$bucket_dir/$pkg/}"
        local dest="$HOME/$rel"
        [ -L "$dest" ] || continue
        # symlink exists and its target resolves
        [ -e "$dest" ] || continue
        return 0
    done < <(find "$bucket_dir/$pkg" -type f -not -name '.DS_Store' -not -name '.description' -print0 2>/dev/null)
    return 1
}

list_bucket() {
    local label="$1" dir="$2"
    echo "$label:"
    for d in "$dir"/*/; do
        [ -d "$d" ] || continue
        local pkg; pkg="$(basename "$d")"
        local info; info="$(desc "$d")"
        local mark=" "
        is_stowed "$dir" "$pkg" && mark="✓"
        printf "  %s %-15s %s\n" "$mark" "$pkg" "$info"
    done
}

case "$ACTION" in
    stow)
        shift
        if [ $# -gt 0 ]; then
            stow_pkgs_from "" core "$OS_BUCKET" -- "$@"
        else
            stow_dir "sources/core" ""
            stow_dir "sources/$OS_BUCKET" ""
        fi
        ;;
    stow-adopt)
        shift
        cleanup_stale
        if [ $# -gt 0 ]; then
            stow_pkgs_from "--adopt" core "$OS_BUCKET" -- "$@"
        else
            stow_dir "sources/core" "--adopt"
            stow_dir "sources/$OS_BUCKET" "--adopt"
        fi
        ;;
    unstow)
        shift
        if [ $# -gt 0 ]; then
            for pkg in "$@"; do
                found=0
                for bucket in "${ALL_BUCKETS[@]}"; do
                    [ -d "sources/$bucket/$pkg" ] || continue
                    stow_pkg "sources/$bucket" "-D" "$pkg" || true
                    found=1
                    break
                done
                [ "$found" -eq 0 ] && echo "  $pkg: not found"
            done
        else
            for bucket in "${ALL_BUCKETS[@]}"; do
                [ -d "sources/$bucket" ] || continue
                for dir in "sources/$bucket"/*/; do
                    [ -d "$dir" ] || continue
                    pkg="$(basename "$dir")"
                    is_stowed "sources/$bucket" "$pkg" || continue
                    stow_pkg "sources/$bucket" "-D" "$pkg" 2>/dev/null || true
                done
            done
        fi
        cleanup_stale
        ;;
    stow-opt|stow-opt-adopt)
        flag=""
        [ "$ACTION" = "stow-opt-adopt" ] && flag="--adopt"
        shift
        stow_pkgs_from "$flag" opt "opt-$OS_BUCKET" -- "$@"
        ;;
    list)
        list_bucket "core" "sources/core"
        list_bucket "$OS_BUCKET" "sources/$OS_BUCKET"
        list_bucket "opt" "sources/opt"
        [ -d "sources/opt-$OS_BUCKET" ] && list_bucket "opt ($OS_BUCKET)" "sources/opt-$OS_BUCKET"
        ;;
    *)
        echo "stow.sh — manage dotfiles with GNU Stow"
        echo ""
        echo "Usage: $0 <command> [pkgs...]"
        echo ""
        echo "Commands:"
        echo "  stow [pkgs...]     Stow core + OS packages (all, or pick specific)"
        echo "  stow-adopt [pkgs]  Same, but adopt existing files into the repo"
        echo "  unstow [pkgs...]   Remove symlinks (all, or pick specific)"
        echo "  stow-opt <pkgs>    Stow optional packages (from opt/ or opt-$OS_BUCKET/)"
        echo "  list               List all available packages by bucket"
        echo ""
        echo "OS: $(uname) → $OS_BUCKET bucket"
        exit 1
        ;;
esac