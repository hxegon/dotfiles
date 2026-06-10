# hxegon/dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
sources/
├── core/     Always stowed (zsh, git, tmux, nvim, etc.)
├── macos/         macOS-only (yabai, hammerspoon, homebrew)
├── linux/         Linux-only (hyprland, xmonad, keyd, xremap, etc.)
└── opt/           Opt-in (kitty, fish, emacs, kakoune, helix)
```

Each subdirectory under a bucket is a stow package — its contents mirror `$HOME`.

## Usage

```bash
# First time on a machine (adopts existing files into the repo)
./stow.sh stow-adopt

# Normal use (after initial setup)
./stow.sh stow

# Remove all symlinks
./stow.sh unstow

# Opt into optional packages
./stow.sh stow-opt kitty fish

# Show available commands
./stow.sh
```
