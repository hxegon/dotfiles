# hxegon/dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
sources/
├── core/         Always stowed (zsh, git, tmux, nvim, bin, lazygit, etc.)
├── macos/        macOS-only, auto-stowed on macOS (yabai, hammerspoon, homebrew)
├── linux/        Linux-only, auto-stowed on Linux (hyprland, xmonad, keyd, xremap, etc.)
├── opt/          Opt-in, any OS (kitty, fish, emacs, kakoune, helix, clojure, haskell)
├── opt-macos/    Opt-in, macOS-only
└── opt-linux/    Opt-in, Linux-only
```

Each subdirectory under a bucket is a stow package — its contents mirror `$HOME`.
A package may include a `.description` file (a one-line summary shown by `list`);
it is ignored when stowing.

The current OS selects the active `macos`/`linux` bucket automatically.

## Usage

Run from the repo root:

```bash
# First time on a machine (adopts existing files into the repo)
./stow.sh stow-adopt

# Normal use (after initial setup) — stow core + this OS's bucket
./stow.sh stow

# Stow only specific core packages (OS bucket still auto-stowed)
./stow.sh stow nvim tmux

# Remove all symlinks (or just specific packages)
./stow.sh unstow
./stow.sh unstow helix kakoune

# Opt into optional packages (from opt/ or opt-<os>/)
./stow.sh stow-opt kitty fish
./stow.sh stow-opt-adopt kitty      # adopt existing files while opting in

# List all packages by bucket (✓ marks what's currently stowed)
./stow.sh list

# Show available commands
./stow.sh
```
