{ pkgs, setup, ... }:

{
  home.packages = with pkgs; [
    nushell
    carapace
    direnv
  ];

  # home.shell.enableNushellIntegration = true;

  programs = {
    carapace.enableNushellIntegration = true;
    direnv.enableNushellIntegration = true;

    nushell = {
      enable = true;

      environmentVariables = {
        # SHELL = "/home/${setup.username}/.nix-profile/bin/"
      };

      shellAliases = {
        ni   = "nvim";
        g    = "git";
        tm   = "tmux";
        lg   = "lazygit";
        j    = "just";
        jc   = "just --choose";
        ".." = "cd ../";
        # lazytsm = "/home/hxegon/Code/hxegon/lazytsm/lazytsm"; # temporary
        # lt = "/home/hxegon/Code/hxegon/lazytsm/lazytsm"; # temporary
      };

      extraConfig = ''
        $env.config.show_banner = false
      '';
    };
  };
}
