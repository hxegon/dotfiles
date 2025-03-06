{ config, pkgs, nixGL, setup, ... }:

{
  imports = [
    # Base imports
    ./modules/tmux.nix
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/nvim.nix
    #./modules/scripts.nix
    #./modules/vm.nix
 
    # Languages
    #./modules/clojure.nix
    # ./modules/python.nix
    #./modules/go.nix

    # Misc
    #./modules/games.nix

    # Scratch/Test module
    #./modules/testing.nix

    # Tmp modules
    # ./modules/ctf.nix

    # DEPRECATED
    # ./modules/kitty.nix
    # ./modules/doom-emacs.nix
    #
    # CONDITIONAL MODULES (See flake setup var)
  ] ++ (if setup.shell == "zsh" then [
      ./modules/zsh.nix
  ] else []);

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hxegon";
  home.homeDirectory = "/home/hxegon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup nixGL (necessary for lots of programs on non-nixOS systems)
  nixGL.packages = nixGL.packages;
  nixGL.defaultWrapper = "mesa";

  # The home.packages option allows you to install Nix packages into your
  # environment.
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

    #yt-dlp # CLI rip video/audio from various sites

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "IosevkaTerm" "Mononoki" ]; })

    # Second brain
    obsidian

    #vhs

    #vscode # in case emacs is having issues

    #zoom-us # video call/meeting app.
    #chromium # browser dev tools + having a backup in case a site doesn't work with firefox

    # Messages
    #discord
    #whatsapp-for-linux

    #nixfmt-classic
    #qemu # VMs

    #libreoffice # Productivity tools

    #vlc # simple media player
    #deluge # torrent client
    # gimp # Photo editing
    # rawtherapee # raw photo editing

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = { BROWSER = "firefox"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
