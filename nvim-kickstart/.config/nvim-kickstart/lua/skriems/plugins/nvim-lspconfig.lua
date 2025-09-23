return { -- LSP Configuration & Pluginslsp
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        map('gr', require('telescope.builtin').lsp_references, 'Goto References')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        map('<leader>lsd', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        map('<leader>lsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('<leader>lr', vim.lsp.buf.rename, 'Rename')
        map('<leader>la', vim.lsp.buf.code_action, 'Code Actions')

        map('<leader>[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')

        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
        vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
        vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Enable the following language servers
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local schemastore = require 'schemastore'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      dockerls = {},
      docker_compose_language_service = {},
      emmet_ls = {
        filetypes = { 'html', 'typescriptreact', 'javascriptreact' },
      },
      eslint = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
        end,
        -- capabilities = {
        --   textDocument = {
        --     formatting = true
        --   }
        -- },
        settings = {
          -- validate = 'on',
          enable = true,
          format = { enable = true },
          autoFixOnSave = true,
          lintTask = { enable = true },
          codeActionsOnSave = {
            mode = 'all',
            rules = { '!debugger', '!no-only-tests/*' },
          },
        },
      },
      jsonls = {
        settings = { json = { schemas = schemastore.json.schemas(), validate = { enable = true } } },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      prettierd = {},
      prismals = {},
      rust_analyzer = {},
      svelte = {},
      tailwindcss = {},
      tsserver = { settings = { format = { enable = false } } },
      yamlls = {
        settings = { yaml = { schemas = schemastore.json.schemas(), validate = { enable = true } } },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server_config = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
          require('lspconfig')[server_name].setup(server_config)
        end,
      },
    }
  end,
}
