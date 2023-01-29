-- General
-- There are additional keymapping in
-- -> config/lsp.lua
-- -> config/lsp.lua

vim.g.mapleader = ","

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "source my vimrc" })
vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<CR>", { desc = "edit my vimrc" })
vim.keymap.set("n", "<leader>ww", ":e $HOME/nextcloud/docs/wiki/index.md<CR>", { desc = "open my wiki" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "exit insert mode" })
vim.keymap.set("n", "<leader>v", ":Vifm<CR>", { desc = "open vim file manager" })
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "open nvim-tree" })
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { desc = "find file in nvim-tree" })
vim.keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>", { desc = "collapse nvim-tree" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "save" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })
vim.keymap.set("n", "<leader>qw", ":wq<CR>", { desc = "quit and save" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "new tab" })
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "toggle undo tree" })
vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { desc = "toggle vim-dadbod-ui" })
vim.keymap.set("n", "<leader>s", ":%s/<<C-r><C-w>>/", { desc = "replace" })
vim.keymap.set("n", "<leader>ip", ":exe ':normal i'.substitute(system('openssl rand --base64 12'),'[\n]*$','','')<CR><ESC>", { desc = 'replace' })
vim.keymap.set("t", "<ESC>", "<C-\\><C-N>", { desc = 'exit terminal' })

-- move text
vim.keymap.set("n", "<C-j>", ":m .+1<CR>")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>") -- TODO gets remapped by lsp
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi") -- TODO gets remapped by lsp
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
-- vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
-- vim.keymap.set("n", "<C-k>", ":m .-2<CR>==") -- TODO gets remapped by lsp
-- vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>") -- TODO gets remapped by lsp
-- vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>")

-- window sizes
vim.keymap.set("n", "H", "<C-w>3<", { desc = "increase width" })
vim.keymap.set("n", "L", "<C-w>3>", { desc = "shrink width" })
vim.keymap.set("n", "K", "<C-w>2+", { desc = "increase height" })
vim.keymap.set("n", "J", "<C-w>2-", { desc = "decrease height" })
vim.keymap.set("n", "E", "<C-w>=", { desc = "equalize window sizes" })

-- because we hijacked J we need to remap J so we can still join lines
-- vim.keymap.set("n", "<C-J>", "gJ", { desc = "join lines" })

-- DAP
vim.keymap.set("n", "<F8>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F9>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
-- vim.keymap.set("n", "<leader>dt", ":lua require('dap-go').debug_test()<CR>")

-- LSP
-- more keymaps _on_attach_ in lsp.lua and tools.lua
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>do", vim.diagnostic.setloclist, opts)

-- Copilot
vim.keymap.set("i", "<leader><C-j>", "<Plug>(copilot-next)", { desc = "open copilot" })
vim.keymap.set("i", "<leader><C-k>", "<Plug>(copilot-previous)", { desc = "open copilot" })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<CR>", opts)
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<CR>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", opts)
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<CR>", opts)

-- Gitsigns
vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")

vim.keymap.set("n", "<leader>hS", ":Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("n", "<leader>hR", ":Gitsigns reset_buffer<CR>")
vim.keymap.set("n", "<leader>hn", ":Gitsigns next_hunk<CR>")
vim.keymap.set("n", "<leader>hp", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>")
vim.keymap.set("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<leader>hd", ":Gitsigns diffthis<CR>")
vim.keymap.set("n", "<leader>td", ":Gitsigns toggle_deleted<CR>")

-- Text object
vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")

-- Pantran (translations)
local pantran = require("pantran")
vim.keymap.set("n", "<leader>tr", pantran.motion_translate, opts)
vim.keymap.set("n", "<leader>trr", function() return pantran.motion_translate() .. "_" end, opts)
vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)

-- rest.nvim-
vim.keymap.set("n", "<leader>rs", ":RunScript<CR>", opts)
