return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
      -- {
      --   "OXY2DEV/markview.nvim",
      --   lazy = false,
      --   opts = {
      --     preview = {
      --       filetypes = { "markdown", "codecompanion" },
      --       ignore_buftypes = {},
      --     },
      --   },
      -- },
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },
  },
}
