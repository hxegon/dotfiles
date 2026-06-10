set positional-arguments := true

_default:
    @just --list

# Auto-detect OS and stow
stow:
    @if [ "$$(uname)" = "Darwin" ]; then \
        just stow-macos; \
    else \
        just stow-linux; \
    fi

# Adopt existing files during stow (use for initial setup)
stow-adopt:
    @if [ "$$(uname)" = "Darwin" ]; then \
        just stow-macos-adopt; \
    else \
        just stow-linux-adopt; \
    fi

# Stow universal + macOS
stow-macos:
    @for dir in sources/universal/*/; do \
        stow -d sources/universal -t ~ "$$(basename "$$dir")"; \
    done
    @for dir in sources/macos/*/; do \
        stow -d sources/macos -t ~ "$$(basename "$$dir")"; \
    done

# Stow universal + macOS (adopt mode)
stow-macos-adopt:
    @for dir in sources/universal/*/; do \
        stow --adopt -d sources/universal -t ~ "$$(basename "$$dir")"; \
    done
    @for dir in sources/macos/*/; do \
        stow --adopt -d sources/macos -t ~ "$$(basename "$$dir")"; \
    done

# Stow universal + Linux
stow-linux:
    @for dir in sources/universal/*/; do \
        stow -d sources/universal -t ~ "$$(basename "$$dir")"; \
    done
    @for dir in sources/linux/*/; do \
        stow -d sources/linux -t ~ "$$(basename "$$dir")"; \
    done

# Stow universal + Linux (adopt mode)
stow-linux-adopt:
    @for dir in sources/universal/*/; do \
        stow --adopt -d sources/universal -t ~ "$$(basename "$$dir")"; \
    done
    @for dir in sources/linux/*/; do \
        stow --adopt -d sources/linux -t ~ "$$(basename "$$dir")"; \
    done

# Stow optional packages (e.g. just stow-opt kitty fish)
stow-opt *pkgs:
    @for pkg in {{pkgs}}; do \
        stow -d sources/opt -t ~ "$$pkg"; \
    done

# Stow optional packages (adopt mode)
stow-opt-adopt *pkgs:
    @for pkg in {{pkgs}}; do \
        stow --adopt -d sources/opt -t ~ "$$pkg"; \
    done

# Unstow optional packages (e.g. just unstow-opt kitty fish)
unstow-opt *pkgs:
    @for pkg in {{pkgs}}; do \
        stow -D -d sources/opt -t ~ "$$pkg"; \
    done

# List available optional packages
list-opt:
    @ls sources/opt/

# Unstow everything
unstow:
    @for bucket in universal macos linux opt; do \
        for dir in sources/$$bucket/*/; do \
            stow -D -d "sources/$$bucket" -t ~ "$$(basename "$$dir")" 2>/dev/null || true; \
        done; \
    done

# Restow (unstow then re-stow, use after git pull)
restow:
    @just unstow && just stow
