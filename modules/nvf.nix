{
  pkgs,
  lib,
  setup,
  ...
}: let
  isLangEnabled = lang:
    lib.mkIf (builtins.elem lang setup.languages) true;
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
        name = "rose-pine";
        style = "main";
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
          # theme = "catppuccin";
          theme = "nord";
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
        surround.enable = true;

        animate.enable = true;
        pairs.enable = true;
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

      languages = {
        enableDAP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        bash.enable = true;
        markdown.enable = true;

        css = {
          enable = isLangEnabled "web";
          format.package = pkgs.prettierd;
        };

        html.enable = isLangEnabled "web";

        ts = {
          enable = isLangEnabled "web";
          format.package = pkgs.prettierd;
        };

        lua.enable = isLangEnabled "lua";
        python.enable = isLangEnabled "python";
        go.enable = isLangEnabled "go";
        nu.enable = isLangEnabled "nu";
        ruby.enable = isLangEnabled "ruby";
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
        # lsplines.enable = false;
        nvim-docs-view.enable = true;
      };

      debugger.nvim-dap = {
        enable = true;
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
        {
          key = "<C-s>";
          action = ":w<CR>";
          lua = false;
          mode = "n";
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
