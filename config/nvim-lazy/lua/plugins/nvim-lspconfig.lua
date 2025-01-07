return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = {
    servers = {
      eslint = {
        -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        -- root_dir = require("lspconfig.util").root_pattern(".eslintrc.js", ".eslintrc", ".git"),
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          problems = {
            shortenToSingleLine = true,
          },
        },
      },
      lua_ls = {},
      vtsls = {},
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
    -- setup = {
    --   eslint = function()
    --     require("lazyvim.util").lsp.on_attach(function(client, bufnr)
    --       if client.name == "eslint" then
    --         client.server_capabilities.documentFormattingProvider = true
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --           buffer = bufnr,
    --           command = "EslintFixAll",
    --         })
    --       elseif client.name == "tsserver" then
    --         client.server_capabilities.documentFormattingProvider = false
    --       elseif client.name == "vtsls" then
    --         client.server_capabilities.documentFormattingProvider = false
    --       end
    --     end)
    --   end,
    -- },
  },
}
