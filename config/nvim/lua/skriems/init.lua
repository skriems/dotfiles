-- the next two lines are needed for nvim-tree.lua
vim.g.loader = 1
vim.g.loaded_netrwPlugin = 1

require('skriems.packer')
require('skriems.options')
require('skriems.augroups')
require('skriems.keymaps')
require('skriems.completions')
-- require('skriems.mason')
require('skriems.dap')
require('skriems.lsp')
require('skriems.telescope')
require('skriems.tools')
require('skriems.treesitter')
