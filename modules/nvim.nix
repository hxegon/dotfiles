{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    steam-run # required to give nvim/mason.nvim a more normal environment
    xsel
    
    kitty # lazyvim requires a modern terminal with truecolor and undercurl
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
    ni = "steam-run nvim";
  };
}
