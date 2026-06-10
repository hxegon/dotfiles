# hxegon/dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
sources/
├── universal/     Always stowed (zsh, git, tmux, nvim, etc.)
├── macos/         macOS-only (yabai, hammerspoon, homebrew)
├── linux/         Linux-only (hyprland, xmonad, keyd, xremap, etc.)
└── opt/           Opt-in (kitty, fish, emacs, kakoune, helix)
```

Each subdirectory under a bucket is a stow package — its contents mirror `$HOME`.

## Usage

```bash
# Auto-detect OS and stow
just stow

# Or explicitly
just stow-macos
just stow-linux

# Initial setup (adopts existing files into the repo)
just stow-adopt

# Optional packages
just stow-opt kitty fish
just list-opt

# Remove all symlinks
just unstow
```
