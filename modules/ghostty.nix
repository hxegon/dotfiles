{ config, lib, pkgs, nixGL, ... }:

{
  programs.ghostty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.ghostty);
    enableBashIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
  };
}
