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

vim.keymap.set("n", "<space>h", "<c-w>h", { desc = "move to left window" })
vim.keymap.set("n", "<space>j", "<c-w>j", { desc = "move to down window" })
vim.keymap.set("n", "<space>k", "<c-w>k", { desc = "move to up window" })
vim.keymap.set("n", "<space>l", "<c-w>l", { desc = "move to right window" })

vim.keymap.set("n", "<space>w", ":wa<CR>", { desc = "write" })
vim.keymap.set("n", "<space>q", ":q<CR>", { desc = "quit" })
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "source current file" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "run line in normal mode" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "run line in normal mode" })

vim.keymap.set("n", "<leader>fp", function()
  require("telescope.builtin").find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end, { desc = "Plugins" })
-- :lua =vim
-- :lua =vim.api
