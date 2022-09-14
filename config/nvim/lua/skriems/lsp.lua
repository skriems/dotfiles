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
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)
  -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap=true, silent=true, buffer=bufnr, async=true })
end


-- required to be called before any servers are set up
require("nvim-lsp-installer").setup({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    check_outdated_servers_on_open = true,
    icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
    }
}
})

require("lspconfig").bashls.setup({
    on_attach = on_attach,
})

require("lspconfig").cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").diagnosticls.setup({
    on_attach = on_attach,
})

require("lspconfig").emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})

require("lspconfig").dockerls.setup({
    on_attach = on_attach,
})

require("lspconfig").eslint.setup({
  on_attach = on_attach,
  settings = {
    codeActionOnSave = {
      enabled = true,
      mode = "all",
    },
    format = true,
    onIgnoredFiles = "off",
    run = "onType",
    validate = "on",
  }
})

-- not sure if `codeActionOnSave` or the below augroup works better
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = "*.tsx,*.ts,*.jsx,*.js",
  group = vim.api.nvim_create_augroup("eslintFix", { clear = true }),
  command ="EslintFixAll",
})

require("lspconfig").html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").intelephense.setup({
    on_attach = on_attach,
})

require("lspconfig").jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").rust_analyzer.setup({
    on_attach = on_attach,
})

require("lspconfig").stylelint_lsp.setup({
    on_attach = on_attach,
  -- settings = {
  --   stylelintplus = {
  --     -- see available options in stylelint-lsp documentation
  --   }
  -- }
})

require("lspconfig").sqlls.setup({
    on_attach = on_attach
})

require("lspconfig").svelte.setup({
    on_attach = on_attach
})

require("lspconfig").tailwindcss.setup({
    on_attach = on_attach
})

require("lspconfig").tsserver.setup({
    on_attach = on_attach
})

require("lspconfig").terraformls.setup({
    on_attach = on_attach
})

require("lspconfig").tsserver.setup({
    on_attach = on_attach
})

require("lspconfig").vimls.setup({
    on_attach = on_attach
})

require("fidget").setup({}) -- standalone UI for nvim-lsp progress. Eye candy for the impatient.

require("null-ls").setup({
  on_attach = on_attach,
  sources = {
    require("null-ls").builtins.code_actions.eslint,
    require("null-ls").builtins.code_actions.gitsigns,
    require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.formatting.prettier,
    require("null-ls").builtins.formatting.stylua,
  },
})
