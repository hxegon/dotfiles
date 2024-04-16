{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      nodePackages.pyright # python LSP
    ];
}
