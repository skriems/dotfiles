-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>")

-- moving code
-- vim.keymap.set("n", "<C-j>", ":m .+1<cr>", { desc = "move line up" })
-- vim.keymap.set("n", "<C-k>", ":m .-2<cr>", { desc = "move line up" })
-- vim.keymap.set("i", "<C-j>", "<esc>:m .+1<cr>==gi", { desc = "move line up" })
-- vim.keymap.set("i", "<C-k>", "<esc>:m .-2<cr>==gi", { desc = "move line up" })
-- vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "move line up" })
-- vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "move line up" })

vim.keymap.set("n", "E", "<C-w>=", { desc = "equalize window size" })
