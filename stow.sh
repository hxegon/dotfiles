#!/usr/bin/env bash
set -euo pipefail

ACTION="${1:-}"
OS="$(uname)"
[ "$OS" = "Darwin" ] && BUCKET="macos" || BUCKET="linux"

stow_dir() {
    local bucket_dir="$1" flag="$2"
    for dir in "$bucket_dir"/*/; do
        [ -d "$dir" ] || continue
        local pkg; pkg="$(basename "$dir")"
        echo "  $pkg"
        if [ "$flag" = "--adopt" ]; then
            stow --no-folding --adopt -d "$bucket_dir" -t "$HOME" "$pkg" 2>/dev/null || \
                stow --no-folding --override='.*' -d "$bucket_dir" -t "$HOME" "$pkg"
        else
            stow --no-folding $flag -d "$bucket_dir" -t "$HOME" "$pkg"
        fi
    done
}

stow_opt() {
    local flag="$1"; shift
    for pkg in "$@"; do
        echo "  $pkg"
        stow --no-folding $flag -d "sources/opt" -t "$HOME" "$pkg"
    done
}

cleanup_stale() {
    echo "Cleaning up stale symlinks from old layout..."
    local count=0
    while IFS= read -r link; do
        [ -z "$link" ] && continue
        local target; target="$(readlink "$link")"
        case "$target" in
            */dotfiles/sources/universal/*|\
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

case "$ACTION" in
    stow)
        stow_dir "sources/universal" ""
        stow_dir "sources/$BUCKET" ""
        ;;
    stow-adopt)
        cleanup_stale
        stow_dir "sources/universal" "--adopt"
        stow_dir "sources/$BUCKET" "--adopt"
        ;;
    unstow)
        for bucket in universal macos linux opt; do
            [ -d "sources/$bucket" ] && stow_dir "sources/$bucket" "-D" 2>/dev/null || true
        done
        ;;
    stow-opt)
        shift; stow_opt "" "$@"
        ;;
    stow-opt-adopt)
        shift; stow_opt "--adopt" "$@"
        ;;
    *)
        echo "Usage: $0 {stow|stow-adopt|unstow|stow-opt <pkg>|stow-opt-adopt <pkg>}"
        exit 1
        ;;
esac