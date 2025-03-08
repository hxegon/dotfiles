{
  pkgs,
  lib,
  setup,
  ...
}: let
  isLangEnabled = lang:
    lib.mkIf (builtins.elem "lang" setup.languages) true;
in {
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

      mini = {
        # https://github.com/echasnovski/mini.surround
        # sd" -> delete surrounding "
        # saiw" -> add " to inner word
        # sr{[ -> replace surrounding {} with []
        animate.enable = true;
        pairs.enable = true;
        surround.enable = true;
        align.enable = true;
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
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Always should be enabled
        nix.enable = true;
        bash.enable = true;
        markdown.enable = true;

        css.enable = isLangEnabled "web";
        html.enable = isLangEnabled "web";
        ts.enable = isLangEnabled "web";

        lua.enable = isLangEnabled "lua";
        python.enable = isLangEnabled "python";
        go.enable = isLangEnabled "go";
        nu.enable = isLangEnabled "nu";
        ruby.enable = isLangEnabled "ruby";
      };

      treesitter = {
        enable = true;
        addDefaultGrammars = true;

        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          just
        ];
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
        {
          key = "<leader><leader>";
          action = "require('telescope.builtin').find_files";
          mode = "n";
          silent = true;
          lua = true;
        }
      ];

      lazy.plugins = {
        "vim-lastplace" = {
          package = pkgs.vimPlugins.vim-lastplace;
        };
      };
    };
  };

  home.shellAliases = {
    ni = "nvim";
  };
}
