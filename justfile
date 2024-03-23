FLAKE := "theseus"

default:
    @just --list

# Build and activate current config without adding it as a boot option
test:
    sudo nixos-rebuild test --flake .#{{FLAKE}}

# Build and activate current config, then add it as the default boot option
[confirm("Really switch to this build?")]
switch:
    sudo nixos-rebuild switch --flake .#{{FLAKE}}

# Clean out the nix store
clean:
    nix-store --gc

# Update flakes
update:
    nix flake update
    echo "Don't forget to add+commit your flake.lock!"
