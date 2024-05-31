{ config, lib, pkgs, ... }:

# Using steam-run for nvim may or may not be necessary. Sometimes nvim only works with steam-run, sometimes it won't work in it.
{
  home.packages = with pkgs; [
    steam-run # required to give nvim/mason.nvim a more normal environment
    xsel

    # plugin build dependencies
    gnumake
    gcc
    unzip
    
    kitty # Terminal with truecolor and undercurl support
  ];

  programs.neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;

      extraPackages = with pkgs; [
        lua-language-server
        shfmt
      ];
  };

  home.file.".config/nvim" = {
    enable = true;
    source = ../sources/nvim/.config/nvim;
    recursive = true;
  };

  home.shellAliases = {
    # ni = "steam-run nvim";
    ni = "nvim";
    sni = "steam-run nvim";
  };
}
