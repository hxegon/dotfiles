return {
  {
    "Olical/conjure",
    ft = { "clojure" },
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = true
    end,
  },
  {
    "clojure-vim/vim-jack-in",
    dependencies = {
      {
        "radenling/vim-dispatch-neovim",
        dependencies = {
          {
            "tpope/vim-dispatch",
          },
        },
      },
    },
  },
}
