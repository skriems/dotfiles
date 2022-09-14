local augroup = vim.api.nvim_create_augroup("vim", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim",
  group = augroup,
  command = "setlocal foldmethod=marker",
})

local augroup = vim.api.nvim_create_augroup("rust", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.rs",
  group = augroup,
  command = "0r ~/.vim/skeleton/rust.rs|norm G",
})

local augroup = vim.api.nvim_create_augroup("bash", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  group = augroup,
  command = "0r ~/.vim/skeleton/bash.sh|norm G",
})

local augroup = vim.api.nvim_create_augroup("python", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.py",
  group = augroup,
  command = "0r ~/.vim/skeleton/python.py|norm G",
})

local augroup = vim.api.nvim_create_augroup("markdown", { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.md,*.mdx",
  group = augroup,
  callback = function()
    vim.api.nvim_command("setlocal foldmethod=marker")
    vim.api.nvim_command("setlocal foldlevel=1")
    vim.api.nvim_command("setlocal foldcolumn=0")
    vim.api.nvim_command("setlocal foldenable")
    vim.opt.textwidth = 79
  end
})

local augroup = vim.api.nvim_create_augroup("two_spaces", { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.svelte,*.lua",
  group = augroup,
  callback = function ()
    vim.api.nvim_command("setlocal softtabstop=2")
    vim.api.nvim_command("setlocal tabstop=2")
    vim.api.nvim_command("setlocal shiftwidth=2")
    vim.api.nvim_command("setlocal expandtab")
  end
})

-- local augroup = vim.api.nvim_create_augroup("colorscheme", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   group = augroup,
--   callback = function()
--     if (vim.g.colors_name == "gruvbox" and vim.o.background == "dark") then
--       vim.cmd[[
--         hi GruvboxYellow gui=italic 
--         hi GruvboxRedSign ctermbg=NONE guibg=NONE
--         hi GruvboxGreenSign ctermbg=NONE guibg=NONE
--         hi GruvboxYellowSign ctermbg=NONE guibg=NONE
--         hi GruvboxBlueSign ctermbg=NONE guibg=NONE
--         hi GruvboxPurpleSign ctermbg=NONE guibg=NONE
--         hi GruvboxAquaSign ctermbg=NONE guibg=NONE
--         hi GruvboxOrangeSign ctermbg=NONE guibg=NONE
--       ]]
--     end
--     if (vim.o.background == "dark") then
--       vim.cmd[[
--         hi Normal ctermbg=NONE guibg=NONE
--         hi NonText ctermbg=NONE guibg=NONE guifg=#3c3836
--         hi SignColumn ctermbg=NONE guibg=NONE
--         hi CursorLineNr ctermbg=NONE guibg=NONE
--       ]]
--     end
--   end
-- })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
  augroup END
]]
