#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-}"
OS="$(uname)"
[ "$OS" = "Darwin" ] && BUCKET="macos" || BUCKET="linux"

stow_pkg() {
    local bucket_dir="$1" flag="$2" pkg="$3"
    echo "  $pkg"
    if [ "$flag" = "--adopt" ]; then
        stow --no-folding --adopt -d "$bucket_dir" -t "$HOME" "$pkg" 2>/dev/null || \
            stow --no-folding --override='.*' -d "$bucket_dir" -t "$HOME" "$pkg"
    else
        stow --no-folding $flag -d "$bucket_dir" -t "$HOME" "$pkg"
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
            local pkg; pkg="$(basename "$dir")"
            stow_pkg "$bucket_dir" "$flag" "$pkg"
        done
    fi
}

cleanup_stale() {
    echo "Cleaning up stale symlinks from old layout..."
    local count=0
    while IFS= read -r link; do
        [ -z "$link" ] && continue
        local target; target="$(readlink "$link")"
        case "$target" in
            */dotfiles/sources/core/*|\
            */dotfiles/sources/macos/*|\
            */dotfiles/sources/linux/*|\
            */dotfiles/sources/opt/*)
                continue ;;
        esac
        case "$target" in
            *dotfiles/sources/*|*dotfiles/bin/*)
                echo "  removing: $link"
                rm -f "$link"
                count=$((count + 1))
                ;;
        esac
    done < <(find "$HOME" -maxdepth 5 -type l 2>/dev/null)
    echo "  removed $count stale symlinks"
}

is_stowed() {
    local bucket_dir="$1" pkg="$2"
    # check if any file from the package exists as a symlink at its target
    local found=0
    while IFS= read -r -d '' src; do
        local rel="${src#$bucket_dir/$pkg/}"
        [ -L "$HOME/$rel" ] && found=1 && break
    done < <(find "$bucket_dir/$pkg" -type f -not -name '.DS_Store' -print0 2>/dev/null)
    [ "$found" -eq 1 ]
}

list_bucket() {
    local label="$1" dir="$2"
    echo "$label:"
    for d in "$dir"/*/; do
        [ -d "$d" ] || continue
        local pkg; pkg="$(basename "$d")"
        if is_stowed "$dir" "$pkg"; then
            echo "  $pkg ✓"
        else
            echo "  $pkg"
        fi
    done
}

case "$ACTION" in
    stow)
        shift
        stow_dir "sources/core" "" "$@"
        stow_dir "sources/$BUCKET" ""
        ;;
    stow-adopt)
        shift
        cleanup_stale
        stow_dir "sources/core" "--adopt" "$@"
        stow_dir "sources/$BUCKET" "--adopt"
        ;;
    unstow)
        for bucket in core macos linux opt; do
            [ -d "sources/$bucket" ] && stow_dir "sources/$bucket" "-D" 2>/dev/null || true
        done
        ;;
    stow-opt)
        shift; stow_dir "sources/opt" "" "$@"
        ;;
    stow-opt-adopt)
        shift; stow_dir "sources/opt" "--adopt" "$@"
        ;;
    list)
        list_bucket "core" "sources/core"
        list_bucket "$BUCKET" "sources/$BUCKET"
        list_bucket "opt" "sources/opt"
        ;;
    *)
        echo "stow.sh — manage dotfiles with GNU Stow"
        echo ""
        echo "Usage: $0 <command> [pkgs...]"
        echo ""
        echo "Commands:"
        echo "  stow [pkgs...]     Stow core + OS packages (all, or pick specific)"
        echo "  stow-adopt [pkgs]  Same, but adopt existing files into the repo"
        echo "  unstow             Remove all stow symlinks"
        echo "  stow-opt <pkgs>    Stow optional packages (e.g. kitty fish)"
        echo "  list               List all available packages by bucket"
        echo ""
        echo "OS: $(uname) → using $BUCKET bucket"
        exit 1
        ;;
esac