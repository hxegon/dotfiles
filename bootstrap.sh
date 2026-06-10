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

if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Install it first:"
        echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi

    if ! command -v stow &>/dev/null; then
        echo "Installing GNU Stow..."
        brew install stow
    fi

    if ! command -v just &>/dev/null; then
        echo "Installing just..."
        brew install just
    fi
elif ! command -v stow &>/dev/null; then
    echo "GNU Stow is not installed. Install it first:"
    echo "  sudo apt install stow / sudo pacman -S stow"
    exit 1
fi

./stow.sh stow

echo ""
echo "Done! Optional packages can be stowed with:"
echo "  ./stow.sh stow-opt <package>"
echo ""
echo "If you have existing configs you want to bring into the repo, use:"
echo "  ./stow.sh stow-adopt [packages...]"
echo "Then review with: git diff"