-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- H/L to jump to first/last non-whitespace on line
vim.keymap.set({ "n", "v" }, "H", "_", { noremap = true, silent = true, desc = "Jump to first non-whitespace" })
vim.keymap.set({ "n", "v" }, "L", "g_", { noremap = true, silent = true, desc = "Jump to last non-whitespace" })

-- Bubble selection up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Bubble selection down" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Bubble selection up" })
