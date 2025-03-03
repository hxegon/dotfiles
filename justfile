FLAKE := "hxegon"

_default:
    @just --list

# Build and activate current config without adding it as a boot option
test:
    sudo nixos-rebuild test --flake .#{{FLAKE}}

# Build and activate current config, then add it as the default boot option
[confirm("Really switch to this build?")]
switch:
    home-manager switch --flake ~/dotfiles
    #sudo nixos-rebuild switch --flake .#{{FLAKE}}

# Delete unreachable paths in /nix/store
gc:
    nix store gc

# deduplicate nix store
optimise:
    nix store optimise

# Maintenance task for cleaning out /nix/store (doesn't include deleting old profiles)
[confirm("This is gonna take a while. Start? (y/n)")]
clean:
    @echo "Starting size:"
    @du -sh /nix/store
    @just gc
    @just optimise
    @echo "After GC + Optimization:"
    @du -sh /nix/store

# Delete profiles older than n days
[confirm("Leave at least a few days of profiles please ;-;. Continue? (y/n)")]
wipe-older-than DAYS:
    nix profile wipe-history --older-than {{DAYS}}d
    @just gc
    @just optimise

# Update flakes
update:
    nix flake update
    @just gc
    @just optimise
    @echo "Don't forget to add+commit your flake.lock!"

# Search for a package in nixpkgs
search *QUERY:
    nix search nixpkgs {{QUERY}}
