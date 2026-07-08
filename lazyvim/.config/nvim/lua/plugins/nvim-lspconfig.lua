return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = {
    servers = {
      oxlint = {},
      -- eslint = {
      --   -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      --   -- root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".eslintrc"),
      --   settings = {
      --     -- workingDirectories = { mode = "auto" },
      --     experimental = {
      --       useFlatConfig = true,
      --     },
      --     -- autoFixOnSave = true,
      --     -- codeActionOnSave = {
      --     --   enable = true,
      --     --   mode = "all",
      --     -- },
      --     -- problems = {
      --     --   shortenToSingleLine = true,
      --     -- },
      --   },
      -- },
      -- biome = {},
      lua_ls = {},
      vtsls = {},
      rust_analyzer = {
        lens = {
          debug = { enable = true },
          enable = true,
          implementations = { enable = true },
          references = {
            adt = { enable = true },
            enumVariant = { enable = true },
            method = { enable = true },
            trait = { enable = true },
          },
          run = { enable = true },
          updateTest = { enable = true },
        },
      },
    },
    setup = {
      eslint = function()
        Snacks.util.lsp.on(function(bufnr, client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "vtsls" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
