set positional-arguments := true

_default:
    @just --list

# Auto-detect OS and stow
stow:
    @./stow.sh stow

# Adopt existing files during stow (use for initial setup)
stow-adopt:
    @./stow.sh stow-adopt

# Stow optional packages (e.g. just stow-opt kitty fish)
stow-opt *pkgs:
    @./stow.sh stow-opt {{pkgs}}

# Stow optional packages (adopt mode)
stow-opt-adopt *pkgs:
    @./stow.sh stow-opt-adopt {{pkgs}}

# Unstow everything
unstow:
    @./stow.sh unstow

# Restow (unstow then re-stow, use after git pull)
restow:
    @just unstow && just stow

# List available optional packages
list-opt:
    @ls sources/opt/
