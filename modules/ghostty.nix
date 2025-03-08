{
  config,
  pkgs,
  setup,
  ...
}: {
  programs.ghostty = {
    enable = true;
    # Necessary to wrap ghostty on non-nixOS systems
    package = config.lib.nixGL.wrap pkgs.ghostty;

    enableBashIntegration = true; # Sometimes need to fall back to bash

    enableZshIntegration =
      if setup.shell == "zsh"
      then true
      else false;

    installBatSyntax = true;

    settings = {
      theme = "catppuccin-mocha";
      command = "/home/${setup.username}/.nix-profile/bin/${setup.shell}";
      # nerd font / unicode stuff not working with this?
      font-family = "Mononoki Nerd Font Mono";
      font-size = 12;
      cursor-style = "block";

      # Necessary for cursor-style to work
      shell-integration-features = "no-cursor";
    };
  };
}
