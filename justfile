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
