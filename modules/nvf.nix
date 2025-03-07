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

      # https://github.com/echasnovski/mini.surround
      # sd" -> delete surrounding "
      # saiw" -> add " to inner word
      # sr{[ -> replace surrounding {} with []
      mini.surround.enable = true;

      utility = {
        motion = {
          leap = {
            enable = true;
            mappings = {
              leapForwardTo = "-";
              leapBackwardTo = "_";
            };
          };
          # hop.enable = true;
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

        # Always should be enabled
        nix.enable = true;

        lua.enable = true;
        markdown.enable = true;
        css.enable = true;
        html.enable = true;
        bash.enable = true;
        python.enable = true;
        go.enable = true;
      };

      keymaps = [
        {
          key = "H";
          action = "_";
          mode = "n";
          silent = true;
          lua = false;
        }
        {
          key = "L";
          action = "g_";
          mode = "n";
          silent = true;
          lua = false;
        }
      ];

      # keymaps = let
      #   keymap = keybind: action: mode: desc: {
      #     inherit action;
      #     inherit desc;
      #     key = keybind;
      #     mode = mode ? "n";
      #     silent = true;
      #     lua = isLua ? false;
      #   };
      # in [
      #   (keymap "<leader><leader>" )
      # ];

      # treesitter.context.enable = true;
    };
  };

  home.shellAliases = {
    ni = "nvim";
  };
}
