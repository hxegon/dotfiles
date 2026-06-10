#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-}"
OS="$(uname)"
[ "$OS" = "Darwin" ] && OS_BUCKET="macos" || OS_BUCKET="linux"

desc() {
    local file="$1/.description"
    [ -f "$file" ] && cat "$file"
}

stow_pkg() {
    local bucket_dir="$1" flag="$2" pkg="$3"
    echo "  $pkg"
    if [ "$flag" = "--adopt" ]; then
        stow --no-folding --ignore='\.description' --adopt -d "$bucket_dir" -t "$HOME" "$pkg" 2>/dev/null || \
            stow --no-folding --ignore='\.description' --override='.*' -d "$bucket_dir" -t "$HOME" "$pkg"
    else
        stow --no-folding --ignore='\.description' $flag -d "$bucket_dir" -t "$HOME" "$pkg"
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

cleanup_stale() {
    echo "Cleaning up stale symlinks..."
    local count=0
    while IFS= read -r link; do
        [ -z "$link" ] && continue
        local target; target="$(readlink "$link")"
        case "$target" in
            *dotfiles/sources/*|*dotfiles/bin/*)
                # resolve relative links against the symlink's directory
                local resolved="$target"
                case "$resolved" in
                    /*) ;;
                    *)  resolved="$(cd "$(dirname "$link")" 2>/dev/null && echo "$PWD/${target}" | sed 's|/\./|/|g')" ;;
                esac
                [ -e "$resolved" ] && continue
                echo "  removing: $link"
                rm -f "$link"
                count=$((count + 1))
                ;;
        esac
    done < <(find "$HOME" -maxdepth 5 -type l 2>/dev/null)
    [ "$count" -gt 0 ] && echo "  removed $count stale symlinks"
}

is_stowed() {
    local bucket_dir="$1" pkg="$2"
    while IFS= read -r -d '' src; do
        local rel="${src#$bucket_dir/$pkg/}"
        local dest="$HOME/$rel"
        [ -L "$dest" ] || continue
        local link; link="$(readlink "$dest")"
        # verify symlink resolves to the current source location
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
        stow_dir "sources/core" "" "$@"
        stow_dir "sources/$OS_BUCKET" ""
        ;;
    stow-adopt)
        shift
        cleanup_stale
        stow_dir "sources/core" "--adopt" "$@"
        stow_dir "sources/$OS_BUCKET" "--adopt"
        ;;
    unstow)
        shift
        if [ $# -gt 0 ]; then
            for pkg in "$@"; do
                found=0
                for bucket in core macos linux opt opt-macos opt-linux; do
                    [ -d "sources/$bucket/$pkg" ] || continue
                    stow_pkg "sources/$bucket" "-D" "$pkg" || true
                    found=1
                    break
                done
                                if [ "$found" -eq 0 ]; then echo "  $pkg: not found"; fi
            done
            cleanup_stale
        else
            for bucket in core macos linux opt opt-macos opt-linux; do
                [ -d "sources/$bucket" ] && stow_dir "sources/$bucket" "-D" 2>/dev/null || true
            done
            cleanup_stale
        fi
        ;;
    stow-opt|stow-opt-adopt)
        flag=""
        [ "$ACTION" = "stow-opt-adopt" ] && flag="--adopt"
        shift
        for pkg in "$@"; do
            found=0
            for bucket in "opt" "opt-$OS_BUCKET"; do
                [ -d "sources/$bucket/$pkg" ] || continue
                stow_pkg "sources/$bucket" "$flag" "$pkg"
                found=1
                break
            done
            [ "$found" -eq 0 ] && echo "  $pkg: not found in opt/ or opt-$OS_BUCKET/"
        done
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