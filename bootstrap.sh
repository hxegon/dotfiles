#!/usr/bin/env bash
set -euo pipefail

echo "Bootstrapping dotfiles with GNU Stow..."

OS="$(uname)"
if [ "$OS" = "Darwin" ]; then
    echo "Detected macOS"
    BUCKET="macos"
elif [ "$OS" = "Linux" ]; then
    echo "Detected Linux"
    BUCKET="linux"
else
    echo "Unknown OS: $OS"
    exit 1
fi

if ! command -v stow &>/dev/null; then
    echo "GNU Stow is not installed. Install it first:"
    echo "  macOS: brew install stow"
    echo "  Linux: sudo apt install stow / sudo pacman -S stow"
    exit 1
fi

echo "Stowing universal packages..."
for dir in sources/universal/*/; do
    pkg="$(basename "$dir")"
    echo "  $pkg"
    stow --adopt -d sources/universal -t "$HOME" "$pkg"
done

echo "Stowing $BUCKET packages..."
for dir in "sources/$BUCKET"/*/; do
    pkg="$(basename "$dir")"
    echo "  $pkg"
    stow --adopt -d "sources/$BUCKET" -t "$HOME" "$pkg"
done

echo ""
echo "Done! Optional packages can be stowed with:"
echo "  just stow-opt <package>"
echo "  just list-opt"
echo ""
echo "Review adopted files with: git diff"
