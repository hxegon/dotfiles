{
  pkgs,
  nixGL,
  lazytsm,
  setup,
  ...
}: let
  getModulesFromMap = modMap: selectedMods:
    with builtins;
      foldl' (mods: availMod:
        if (elem availMod selectedMods)
        then mods ++ [modMap.${availMod}]
        else mods) [] (builtins.attrNames modMap);

  # TODO: Enable selecting more than one shell
  shellModuleMap = {
    zsh = ./modules/zsh.nix;
  };

  featureModuleMap = {
    desktop-apps = ./modules/desktop-apps.nix;
  };

  langModuleMap = {
    go = ./modules/go.nix;
    clojure = ./modules/clojure.nix;
    python = ./modules/python.nix;
  };

  tempModules = [
    ./modules/nushell.nix
    # ./modules/testing.nix
    # ./modules/ctf.nix
  ];

  activatedModules =
    [shellModuleMap."${setup.shell}"]
    # get selected language modules
    ++ getModulesFromMap langModuleMap setup.languages
    ++ getModulesFromMap featureModuleMap setup.features;
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
      #./modules/scripts.nix # TODO: Import scripts as local package
      #./modules/vm.nix

      # Misc
      #./modules/games.nix

      # DEPRECATED
      # ./modules/kitty.nix
      # ./modules/doom-emacs.nix
      # ./modules/nvim.nixw
    ]
    ++ activatedModules
    ++ tempModules;

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
      LC_ALL = "en_US.UTF8";
      LANG = "en_US.UTF8";
    };

    packages = with pkgs;
      [
        #yt-dlp # CLI rip video/audio from various sites

        (pkgs.nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "IosevkaTerm" "Mononoki"];})

        #vhs
        #qemu # VMs

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ]
      ++ [lazytsm.packages.${system}.default];
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup nixGL (necessary for lots of GUI programs on non-nixOS systems)
  nixGL.packages = nixGL.packages;
  nixGL.defaultWrapper = "mesa"; # Might need to change this per system

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
