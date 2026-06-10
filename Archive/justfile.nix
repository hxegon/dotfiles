FLAKE := "hxegon"

_default:
    @just --list

# Build and current config without actiating it
build:
    home-manager build --flake ~/dotfiles

# Build and activate current config, then add it as the default boot option
[confirm("Really switch to this build?")]
switch:
    home-manager switch --flake ~/dotfiles

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
    # @just optimise

# Update flakes
update:
    nix flake update
    @echo "Don't forget to add+commit your flake.lock!"

# Search for a package in nixpkgs
search *QUERY:
    nix search nixpkgs {{QUERY}}

# TODO: Move this into a system specific nix script command
restart-power-manager:
  xfce4-power-manager --restart
  sudo systemctl restart upower
