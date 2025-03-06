{ config, lib, pkgs, nixGL, setup, ... }:

{
  programs.ghostty = {
    enable = true;
    # Necessary to wrap ghostty on non-nixOS systems
    package = (config.lib.nixGL.wrap pkgs.ghostty);
    enableBashIntegration = true;
    enableZshIntegration = (if setup.shell == "zsh" then true else false);
    installBatSyntax = true;
    settings = {
      command = "/home/${setup.username}/.nix-profile/bin/${setup.shell}";
    };
  };
}
