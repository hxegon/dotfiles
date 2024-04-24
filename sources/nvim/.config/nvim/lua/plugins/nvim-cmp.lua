return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- Disable completing with enter and move it to ctrl-y
        ["<CR>"] = function(fallback)
          fallback()
        end,
        ["<C-y>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
      })
    end,
  },
}
