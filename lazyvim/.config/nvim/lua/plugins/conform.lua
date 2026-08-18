local web_formatters = {
  "oxfmt",
  "biome-check",
  "prettierd",
  "oxfmt_fallback",
  stop_after_first = true,
}

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxfmt", "prettierd" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        astro = web_formatters,
        javascript = web_formatters,
        javascriptreact = web_formatters,
        json = web_formatters,
        jsonc = web_formatters,
        svelte = web_formatters,
        typescript = web_formatters,
        typescriptreact = web_formatters,
        vue = web_formatters,
      },
      formatters = {
        -- Explicit project configuration wins; otherwise continue down the chain.
        oxfmt = { require_cwd = true },
        prettierd = { require_cwd = true },
        oxfmt_fallback = {
          inherit = "oxfmt",
          cwd = function(_, ctx)
            return ctx.dirname
          end,
          require_cwd = false,
        },
      },
    },
  },
}
