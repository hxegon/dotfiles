-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set H/L to first/last on line non-whitespace jump
vim.keymap.set("n", "H", "_", { noremap = true, silent = true })
vim.keymap.set("n", "L", "g_", { noremap = true, silent = true })
