local js_linters = {
  "biome-check",
  "eslint",
  "prettierd",
  stop_after_first = true,
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = js_linters,
        javascriptreact = js_linters,
        typescript = js_linters,
        typescriptreact = js_linters,
      },
    },
  },
}
