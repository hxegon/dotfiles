{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      brogue-ce
    ];
}
