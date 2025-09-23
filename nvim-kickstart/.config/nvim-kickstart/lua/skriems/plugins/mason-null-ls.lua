return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    { 'nvimtools/none-ls.nvim', opts = { debug = true } },
  },
  opts = function(_, opts)
    opts.ensure_installed = { 'prettierd' }
    opts.automatic_installation = true

    -- local has_prettier = function(util)
    --   local utils = require 'skriems.utils'
    --   return utils.json_key_exists(vim.fn.getcwd() .. '/package.json', 'prettier')
    --     or util.root_has_file '.prettierrc'
    --     or util.root_has_file '.prettierrc.json'
    --     or util.root_has_file '.prettierrc.yml'
    --     or util.root_has_file '.prettierrc.yaml'
    --     or util.root_has_file '.prettierrc.json5'
    --     or util.root_has_file '.prettierrc.js'
    --     or util.root_has_file '.prettierrc.cjs'
    --     or util.root_has_file 'prettier.config.js'
    --     or util.root_has_file '.prettierrc.mjs'
    --     or util.root_has_file 'prettier.config.mjs'
    --     or util.root_has_file 'prettier.config.cjs'
    --     or util.root_has_file '.prettierrc.toml'
    -- end
    opts.handlers = {}
    -- opts.handlers.prettierd = function()
    --   local none_ls = require 'none-ls'
    --   none_ls.register(none_ls.builtins.formatting.prettierd.with { condition = has_prettier })
    -- end
    -- opts.handlers.eslint = function()
    --   local null_ls = require 'null-ls'
    --   null_ls.register(null_ls.builtins.formatting.eslint)
    -- end
    opts.sources = {
      -- require('null-ls').builtins.code_actions.eslint,
      -- require('null-ls').builtins.diagnostics.eslint,
      require('null-ls').builtins.formatting.prettierd,
    }
    return opts
  end,
}
