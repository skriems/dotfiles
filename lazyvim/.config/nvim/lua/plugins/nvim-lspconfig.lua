return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = {
    servers = {
      eslint = {
        -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        -- root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".eslintrc"),
        settings = {
          -- workingDirectories = { mode = "auto" },
          experimental = {
            useFlatConfig = true,
          },
          -- autoFixOnSave = true,
          -- codeActionOnSave = {
          --   enable = true,
          --   mode = "all",
          -- },
          -- problems = {
          --   shortenToSingleLine = true,
          -- },
        },
      },
      biome = {},
      lua_ls = {},
      vtsls = {},
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client, bufnr)
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
