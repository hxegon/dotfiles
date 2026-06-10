{
  pkgs,
  setup,
  ...
}: {
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
    fzf
    ripgrep
    direnv
    starship
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      SHELL = "/home/${setup.username}/.nix-profile/bin/zsh";
      ZSH_AUTOSUGGEST_STRATEGY = "history completion";
    };

    defaultKeymap = "emacs";

    shellAliases = {
      g = "git";
      tm = "tmux";
      lg = "lazygit";
      lt = "lazytsm";
      j = "just";
      jc = "just --choose";
      ".." = "cd ../";
      la = "ls -a";
    };

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "docker"];
      theme = "lambda";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
