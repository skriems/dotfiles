return {
  {
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "eslint-lsp",
        "stylua",
      })
      opts.automatic_installtion = true
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      opts.sources = {
        -- Set a formatter
        -- require("null-ls").builtins.code_actions.eslint_d,
        -- require("null-ls").builtins.diagnostics.eslint_d,
        -- require("null-ls").builtins.formatting.eslint,
        -- require("null-ls").builtins.formatting.prettierd,
      }
      return opts -- return final config table
    end,
  },
}
