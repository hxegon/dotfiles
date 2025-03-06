{
  # config,
  # lib,
  # pkgs,
  ...
}: {
  programs.nvf = {
    # Lots of this copied from https://github.com/NotAShelf/nvf/blob/main/configuration.nix
    # Other stuff from https://github.com/Kerdonov/nvf-configuration/blob/main/default.nix

    enable = true;

    settings.vim = {
      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = false;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      vimAlias = true;
      spellcheck.enable = true;

      autocomplete.nvim-cmp.enable = true;
      notify.nvim-notify.enable = true;
      projects.project-nvim.enable = true;
      comments.comment-nvim.enable = true;

      utility = {
        surround.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
          # precognition.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
      };

      lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
        lsplines.enable = true;
        nvim-docs-view.enable = true;
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
      };

      treesitter.context.enable = true;
    };
  };

  home.shellAliases = {
    ni = "nvim";
  };
}
