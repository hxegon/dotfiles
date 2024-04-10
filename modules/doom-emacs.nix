{ config, pkgs, ... }:
let doomAlias = "emacsclient -t";
in {
  # TODO: Emacs29 lets you specify a custom init folder, maybe init directly from sources
  # to avoid having to rebuild nix every time?
  # TODO: Automatically doom sync when config changes.

  home.packages = with pkgs; [
    # core doom emacs dependencies
    git
    emacs29
    ripgrep
    coreutils
    fd
    clang
    python3 # required for some neotree features

    shellcheck

    emacsPackages.vterm

    sqlite # For org-roam
  ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];
  home.sessionVariables = { EDITOR = doomAlias; };

  # dm alias will start a emacs server if there isn't one already
  home.shellAliases = { dm = doomAlias; };

  home.file.".config/doom" = {
    enable = true;
    source = ../sources/doom_emacs/.config/doom;
    recursive = true;
    # onChange = "~/.config/emacs/bin/doom sync";
  };

}
