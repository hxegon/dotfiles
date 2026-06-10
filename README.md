# hxegon/dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
sources/
├── core/         Always stowed (zsh, git, tmux, nvim, bin, lazygit, lf, fd, vscode)
├── macos/        macOS-only, auto-stowed on macOS (homebrew)
├── linux/        Linux-only, auto-stowed on Linux
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
# First-time setup — installs brew/stow/just, stows dotfiles
./bootstrap.sh

# Stow core + this OS (after bootstrap, or after adding new packages)
./stow.sh stow

# Stow only specific core packages (OS bucket still auto-stowed)
./stow.sh stow nvim tmux

# Remove all symlinks (or just specific packages)
./stow.sh unstow
./stow.sh unstow helix kakoune

# Opt into optional packages (from opt/ or opt-<os>/)
./stow.sh stow-opt kitty fish

# Adopt existing $HOME files into the repo (review with git diff)
./stow.sh stow-adopt

# List all packages by bucket (✓ marks what's currently stowed)
./stow.sh list

# Show available commands
./stow.sh
```

## Homebrew (macOS)

Declarative package management with `just` + Brewfile modules. Core essentials in
`~/.Brewfile`, optional packages in `sources/macos/homebrew/modules/`.

```bash
just                          # list available recipes
just install                  # install core packages
just install-module net       # install one module (deduped against core)
just install-all              # install all modules (excluding trash)
just uninstall nmap           # remove from Brewfiles, archive to trash
just sync                     # list installed-but-not-declared packages
just adopt nmap net           # add an installed package to a module Brewfile
just diff                     # show drift between declared and installed
```

From the repo root, `just brew <cmd>` proxies to the homebrew justfile.
