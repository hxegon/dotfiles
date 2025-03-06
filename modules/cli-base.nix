{ config, pkgs, setup, ... }:

{
  home.packages = with pkgs; [
    # System monitors
    btop
    htop

    git
    curl
    wget
    #asdf-vm # universal version manager
    just # command runner like make or rake
    entr # exec commands on file change
    bat # better pager

    fd # `find` with a human friendly interface
    ripgrep # BLAZINGLY FAST text search
    lf # cli file manager
    zstd # my preferred compression stuff
    tldr # Quick command examples for a lot of stuff
    xsel # clipboard cli (cat foo.txt | xsel -ib)
    tree # List files/folders in a tree view
    watch # run a command / display output repeatedly

    fzf # generic fuzzy finder
  ];

  programs.fzf = {
    fileWidgetCommand = "rg --files";
  };
}
