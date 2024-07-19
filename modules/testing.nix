{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      mariadb # For appian interview problem
    ];
}
