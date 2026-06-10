#!/usr/bin/env bash
set -euo pipefail

echo "Bootstrapping dotfiles with GNU Stow..."

OS="$(uname)"
if [ "$OS" = "Darwin" ]; then
    echo "Detected macOS"
elif [ "$OS" = "Linux" ]; then
    echo "Detected Linux"
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

./stow.sh stow-adopt

echo ""
echo "Done! Optional packages can be stowed with:"
echo "  ./stow.sh stow-opt <package>"
echo ""
echo "Review adopted files with: git diff"