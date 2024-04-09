{ config, pkgs, ... }: {
  # TODO: Use emacs client/server setup

  home.packages = with pkgs; [
    # core doom emacs dependencies
    git
    emacs
    ripgrep
    coreutils
    fd
    clang
    python3 # required for some neotree features

    shellcheck

    emacsPackages.vterm

    # For org-roam
    sqlite
    emacsPackages.emacsql
  ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];

  home.shellAliases = { e = "emacs -nw"; };

  home.file.".config/doom" = {
    enable = true;
    source = ../sources/doom_emacs/.config/doom;
    recursive = true;
    # onChange = "~/.config/emacs/bin/doom sync";
  };

}
