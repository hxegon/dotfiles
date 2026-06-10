{ config, lib, pkgs, ... }:

# Using steam-run for nvim may or may not be necessary. Sometimes nvim only works with steam-run, sometimes it won't work in it.
{
  home.packages = with pkgs; [
    kitty # Terminal with truecolor and undercurl support
  ];

  programs.kitty = {
    enable = true;
  };

  home.file.".config/kitty" = {
    enable = true;
    source = ../sources/kitty/.config/kitty;
    recursive = true;
  };

  # home.shellAliases = {
  # };
}
