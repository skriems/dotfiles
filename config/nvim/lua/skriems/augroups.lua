-- local augroup = vim.api.nvim_create_augroup("two_spaces", { clear = true })
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = "*.html,*.css,*.php,*.json,*.js,*.cjs,*.jsx,*.ts,*.tsx,*.svelte,*.lua",
--   group = augroup,
--   callback = function ()
--     vim.api.nvim_command("setlocal softtabstop=2")
--     vim.api.nvim_command("setlocal shiftwidth=2")
--   end
-- })

local augroup = vim.api.nvim_create_augroup("mdx", { clear = true })
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = "*.mdx",
  group = augroup,
  callback = function ()
    vim.api.nvim_command("set filetype=markdown")
  end
})


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
