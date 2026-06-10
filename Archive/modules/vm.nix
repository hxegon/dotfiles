{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ virt-manager ];
  # programs.virt-manager.enable = true;
}
