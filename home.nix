{
  pkgs,
  nixGL,
  setup,
  ...
}: let
  shellModules = {
    zsh = ./modules/zsh.nix;
  };

  langModules = {
    go = ./modules/go.nix;
    clojure = ./modules/clojure.nix;
    python = ./modules/python.nix;
  };

  activatedModules =
    [shellModules."${setup.shell}"]
    # Get corresponding modules for specified langs in setup.Languages
    ++ builtins.foldl' (mods: mkey:
      if (builtins.elem mkey setup.languages)
      then mods ++ langModules."${mkey}"
      else mods) [] (builtins.attrNames langModules);
in {
  # Better integration for DEs
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  imports =
    [
      # Base imports
      ./modules/cli-base.nix
      ./modules/tmux.nix
      ./modules/git.nix
      ./modules/ghostty.nix
      ./modules/nvf.nix
      # ./modules/nvim.nixw
      #./modules/scripts.nix # TODO: Import scripts as local package
      #./modules/vm.nix

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
    ]
    ++ activatedModules;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "${setup.username}";
    homeDirectory = "/home/${setup.username}";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    sessionVariables = {
      BROWSER = "firefox";
    };

    packages = with pkgs; [
      #yt-dlp # CLI rip video/audio from various sites

      (pkgs.nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "IosevkaTerm" "Mononoki"];})

      # Second brain
      obsidian

      #vhs

      #vscode # in case $EDITOR is having issues

      #zoom-us # video call/meeting app.
      #chromium # browser dev tools + having a backup in case a site doesn't work with firefox

      # Messages
      #discord
      #whatsapp-for-linux

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
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup nixGL (necessary for lots of GUI programs on non-nixOS systems)
  nixGL.packages = nixGL.packages;
  nixGL.defaultWrapper = "mesa"; # Might need to change this per system

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
