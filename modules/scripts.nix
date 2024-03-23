{ config, lib, pkgs, ... }:

{
  # Not sure how to manage my scripts through nix cleanly yet,
  # but I can at least start by adding the path here.
  home.sessionPath = ["$HOME/scripts"];
}
