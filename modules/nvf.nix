{
  lib,
  setup,
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
      mini = {
        surround.enable = true;
        # indentscope.enable = true;
      };

      navigation = {
        harpoon = {
          enable = true;

          mappings = {
            listMarks = "<leader>h";
            markFile = "<leader>H";
            file1 = "<leader>1";
            file2 = "<leader>2";
            file3 = "<leader>3";
            file4 = "<leader>4";
          };

          setupOpts.defaults = {
            save_on_toggle = true;
            sync_on_ui_close = true;
          };
        };
      };

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

      # TODO: enable languages based on setup var
      languages = {
        enableLSP = true;
        enableFormat = false;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Always should be enabled
        nix.enable = true;
        bash.enable = true;
        markdown.enable = true;

        css.enable = lib.mkIf (builtins.elem "web" setup.languages) true;
        html.enable = lib.mkIf (builtins.elem "web" setup.languages) true;
        ts.enable = lib.mkIf (builtins.elem "web" setup.languages) true;

        lua.enable = lib.mkIf (builtins.elem "lua" setup.languages) true;
        python.enable = lib.mkIf (builtins.elem "python" setup.languages) true;
        go.enable = lib.mkIf (builtins.elem "go" setup.languages) true;
        nu.enable = lib.mkIf (builtins.elem "nu" setup.languages) true;
        ruby.enable = lib.mkIf (builtins.elem "ruby" setup.languages) true;
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
        {
          key = "<leader>f<leader>";
          action = "require('telescope.builtin').git_files";
          mode = "n";
          silent = true;
          lua = true;
        }
      ];


      # treesitter.context.enable = true;
    };
  };

  home.shellAliases = {
    ni = "nvim";
  };
}
