# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each bucket under `sources/` contains stow
packages whose files mirror `$HOME`. Packages may include a `.description` file for one-line summaries.

Update this AGENTS.md when any major changes are made. Supplementary docs can be added to docs/, but keep AGENTS.md minimal.

## Buckets

| Bucket | Scope |
|---------|-------|
| `core/` | Always stowed — zsh, git, tmux, nvim, bin, lazygit, lf, fd, vscode |
| `macos/` | Auto-stowed on macOS |
| `linux/` | Auto-stowed on Linux |
| `opt/` | Opt-in, any OS — kitty, fish, emacs, kakoune, helix, clojure, haskell |
| `opt-macos/` | Opt-in, macOS-only |
| `opt-linux/` | Opt-in, Linux-only |

## Key scripts

| Script | Purpose |
|--------|---------|
| `bootstrap.sh` | First-time setup — checks OS, ensures brew/stow/just installed, runs `./stow.sh stow` |
| `stow.sh` | Main entry point — `stow`, `unstow`, `stow-opt`, `stow-adopt`, `list`, etc. |
| `sources/macos/homebrew/brew-helper` | Homebrew package management — `sync`, `adopt`, `diff`, `dump`, `dedup`, `uninstall` |

## Usage

```bash
./stow.sh stow            # stow core + this OS
./stow.sh stow nvim tmux  # stow specific core packages + OS
./stow.sh unstow          # remove all symlinks
./stow.sh stow-opt kitty fish  # opt into optional packages
./stow.sh stow-adopt      # adopt existing $HOME files into the repo (manual, review with git diff)
./stow.sh list            # show all packages (✓ = currently stowed)
./bootstrap.sh            # first-time setup — installs brew/stow/just, stows dotfiles
```

## Patterns

- **Symlink management**: stow creates symlinks from `sources/<bucket>/<pkg>/...` → `$HOME/...`
- **OS detection**: `uname` → `Darwin` = macos bucket, anything else = linux bucket
- **Adopt mode**: `--adopt` flag moves existing real files into the repo and replaces with symlinks
- **Cleanup**: `unstow` and `stow-adopt` both clean up stale/broken symlinks after operation
- **Ignore files**: `.description` and `.stowignore` are never stowed; `.DS_Store` is gitignored
- **Per-package ignore**: `.stowignore` in any package dir lists regex patterns (one per line) for `stow --ignore`
- **Generated files**: Emacs, Fish, Kitty themes, Kakoune plugins, Xmonad binaries — gitignored and regenerated locally

## Homebrew (macOS)

Declarative package management with `just` + Brewfile modules. The `homebrew` package in `sources/macos/homebrew/` is auto-stowed on macOS.

```
sources/macos/homebrew/
├── .Brewfile              # core essentials (stows to ~/.Brewfile)
├── justfile               # just runner (stows to ~/justfile)
├── brew-helper            # package management script (NOT stowed)
├── .stowignore            # ignores modules/ and brew-helper from stow
└── modules/               # optional brew modules (NOT stowed — lives only in repo)
    ├── net.Brewfile
    ├── dev.Brewfile
    ├── work.Brewfile
    ├── ...
    ├── fonts.Brewfile
    ├── trash.Brewfile      # archive of uninstalled packages
    └── apps/
        └── discord.Brewfile (one file per GUI app)
```

```bash
just install                  # install core only
just install-module net       # install one module (deduped against core)
just install-all              # install all modules (excluding trash)
just uninstall nmap           # remove from Brewfiles, archive to trash, untap if orphaned
just sync                     # list installed-but-not-declared packages
just adopt nmap net           # add installed package to a module Brewfile
just diff                     # show drift between declared and installed
just dump                     # print current brew leaves/casks/taps in Brewfile format
```

`just` with no args lists available recipes (built-in `--list` behavior). From the repo root, `just brew <cmd>` proxies to the homebrew justfile.

## Archive/

Old NixOS configuration (flake.nix, home.nix, etc.). Not actively used — kept for reference.
