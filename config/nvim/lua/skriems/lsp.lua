require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
  automatic_setup = true,
})

require("inlay-hints").setup()  -- enabled inlay type hints
require("fidget").setup({})     -- UI for nvim-lsp progress

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader><C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,

  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function ()
    -- require("rust-tools").setup {}
    require("lspconfig").rust_analyzer.setup {
      on_attach = function (client, bufnr) 
        require('inlay-hints').on_attach(client, bufnr)
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    }
  end,

  -- ["emmet_ls"] = function ()
  --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
  -- end

  ["eslint"] = function ()
    require("lspconfig").eslint.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        codeActionOnSave = {
          enabled = true,
          mode = "all",
        },
        format = true,
        onIgnoredFiles = "off",
        run = "onSave",
        validate = "on",
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
            }
        )
      }
    }
  end,

  ["tailwindcss"] = function ()
    require("lspconfig").tailwindcss.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              "cva\\(([^)]*)\\)",
              "[\"'`]([^\"'`]*).*?[\"'`]",
            },
          },
        },
      },
    }
  end,

  -- ["null_ls"] = function ()
  --   lspconfig.null_ls.setup {
  --     on_attach = on_attach,
  --     capabilities = capabilities,
  --     sources = {
  --       require("null-ls").builtins.code_actions.eslint,
  --       require("null-ls").builtins.code_actions.gitsigns,
  --       require("null-ls").builtins.completion.luasnip,
  --       require("null-ls").builtins.diagnostics.eslint,
  --       require("null-ls").builtins.formatting.prettier,
  --       require("null-ls").builtins.formatting.stylua,
  --     }
  --   }
  -- end,
}

-- not sure if `codeActionOnSave` or the below augroup works better
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*.tsx,*.ts,*.jsx,*.js",
  group = vim.api.nvim_create_augroup("eslintFix", { clear = true }),
  command ="EslintFixAll",
})

-- require("lspconfig").tsserver.setup({
--   on_attach = function (client, bufnr) 
--     require('inlay-hints').on_attach(client, bufnr)
--     on_attach(client, bufnr)
--   end,
--   capabilities = capabilities,
--     settings = {
--     javascript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--     typescript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--   },
-- })
