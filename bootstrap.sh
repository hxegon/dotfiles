#!/usr/bin/env bash
# Based off of some info from https://www.chrisportela.com/posts/home-manager-flake/

# Install nix
echo "Installing nix as single user"
# https://nixos.org/download/
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable nix flakes feature
echo "Enabling flakes"
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf

# TODO: Ask for conf that initially loaded modules have been reviewed, abort if not

# Initial nix run
echo "Bootstrapping nix. THIS IS UNTESTED"
. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Need to remove .zshrc so nix doesn't have a collision when replacing
rm ~/.zshrc
nix run . -- switch --flake .
home-manager switch --flake .

# TODO: Optional cloning of scripts into ~/bin
