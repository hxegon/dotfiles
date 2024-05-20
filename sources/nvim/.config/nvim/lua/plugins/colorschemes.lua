return {
  { "rktjmp/lush.nvim" }, -- Require up front to prevent some lazy loading issues
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {
    "mcchrish/zenbones.nvim",
    name = "zenbones",
    dependencies = { "rktjmp/lush.nvim" }
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa"
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    name = "oxocarbon"
  },
  {
    "sainnhe/everforest",
    name = "everforest"
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github"
  },
  -- Set colorscheme here
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa"
    }
  }
}
