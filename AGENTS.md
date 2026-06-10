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
| `bootstrap.sh` | First-time setup — checks OS + stow installed, runs `stow-adopt` |
| `stow.sh` | Main entry point — `stow`, `unstow`, `stow-opt`, `list`, etc. |

## Usage

```bash
./stow.sh stow            # stow core + this OS
./stow.sh stow nvim tmux  # stow specific core packages + OS
./stow.sh unstow          # remove all symlinks
./stow.sh stow-opt kitty fish  # opt into optional packages
./stow.sh list            # show all packages (✓ = currently stowed)
./bootstrap.sh            # first-time setup (adopts existing files)
```

## Patterns

- **Symlink management**: stow creates symlinks from `sources/<bucket>/<pkg>/...` → `$HOME/...`
- **OS detection**: `uname` → `Darwin` = macos bucket, anything else = linux bucket
- **Adopt mode**: `--adopt` flag moves existing real files into the repo and replaces with symlinks
- **Cleanup**: `unstow` and `stow-adopt` both clean up stale/broken symlinks after operation
- **Ignore files**: `.description` is never stowed; `.DS_Store` is gitignored
- **Generated files**: Emacs, Fish, Kitty themes, Kakoune plugins, Xmonad binaries — gitignored and regenerated locally

## Archive/

Old NixOS configuration (flake.nix, home.nix, etc.). Not actively used — kept for reference.
