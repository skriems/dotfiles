return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      -- if you want to use typescript-tools you have to
      -- disable tsserver and ts_ls and vtsls
      -- tsserver = { enabled = false },
      -- ts_ls = { enabled = false },
      -- vtsls = { enabled = false },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
