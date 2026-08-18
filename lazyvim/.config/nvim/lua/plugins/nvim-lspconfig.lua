return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = {
    servers = {
      oxlint = {
        settings = {
          fixKind = "safe_fix",
        },
      },
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
    },
  },
}
