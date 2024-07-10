-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local utils = require 'skriems.utils'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>confirm q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>cb', function()
  utils.close_buffer()
end, { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>|', '<cmd>vs<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>\\', '<cmd>sp<cr>', { desc = 'Horizontal Split' })

vim.keymap.set('n', 'E', '<C-w>=', { desc = 'equalize window size' })

-- moving code
vim.keymap.set('n', '<C-j>', ':m .+1<cr>', { desc = 'move line up' })
vim.keymap.set('n', '<C-k>', ':m .-2<cr>', { desc = 'move line up' })
vim.keymap.set('i', '<C-j>', '<esc>:m .+1<cr>==gi', { desc = 'move line up' })
vim.keymap.set('i', '<C-k>', '<esc>:m .-2<cr>==gi', { desc = 'move line up' })
vim.keymap.set('v', '<C-j>', ":m '>+1<cr>gv=gv", { desc = 'move line up' })
vim.keymap.set('v', '<C-k>', ":m '<-2<cr>gv=gv", { desc = 'move line up' })

-- comment.nvim
vim.keymap.set('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = 'Toggle comment for selection' })

-- Neotree
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neotree' })
vim.keymap.set('n', '<leader>o', function()
  if vim.bo.filetype == 'neo-tree' then
    vim.cmd.wincmd 'p'
  else
    vim.cmd.Neotree 'focus'
  end
end, { desc = 'Focus Neotree' })

-- Lazy
vim.keymap.set('n', '<leader>pi', function()
  require('lazy').install()
end, { desc = 'Plugins Install' })
vim.keymap.set('n', '<leader>ps', function()
  require('lazy').home()
end, { desc = 'Plugins Status' })
vim.keymap.set('n', '<leader>pS', function()
  require('lazy').sync()
end, { desc = 'Plugins Sync' })
vim.keymap.set('n', '<leader>pu', function()
  require('lazy').check()
end, { desc = 'Plugins Check Updates' })
vim.keymap.set('n', '<leader>pU', function()
  require('lazy').update()
end, { desc = 'Plugins Update' })
