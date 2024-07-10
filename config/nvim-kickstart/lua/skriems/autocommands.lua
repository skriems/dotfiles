-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*lazygit*',
  desc = 'Refresh Neo-Tree when closing lazygit',
  group = vim.api.nvim_create_augroup('neotree_refresh', { clear = true }),
  callback = function()
    local manager_avail, manager = pcall(require, 'neo-tree.sources.manager')
    if manager_avail then
      for _, source in ipairs { 'filesystem', 'git_status', 'document_symbols' } do
        local module = 'neo-tree.sources.' .. source
        if package.loaded[module] then
          manager.refresh(require(module).name)
        end
      end
    end
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('eslint_fix_creator', { clear = true }),
--   desc = 'Create autocommand in buffers where eslint attaches',
--   callback = function(args)
--     if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == 'eslint' then
--       vim.api.nvim_create_autocmd('BufWritePost', {
--         desc = 'Fix all eslint errors',
--         buffer = args.buf,
--         group = vim.api.nvim_create_augroup(('eslint_fix_%d'):format(args.buf), { clear = true }),
--         callback = function()
--           if vim.fn.exists ':EslintFixAll' > 0 then
--             vim.notify('EslintFixAll', 'DEBUG')
--             vim.cmd.EslintFixAll()
--           end
--         end,
--       })
--     end
--   end,
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
