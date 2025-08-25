-- https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "j-hui/fidget.nvim", -- Display status,
      "franco-ruggeri/codecompanion-spinner.nvim", -- progress spinner
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
      -- {
      --   "echasnovski/mini.diff",
      --   config = function()
      --     local diff = require("mini.diff")
      --     diff.setup({
      --       -- Disabled by default
      --       source = diff.gen_source.none(),
      --     })
      --   end,
      -- },
    },
    opts = {
      ---@module "codecompanion"
      ---@type CodeCompanion.Config
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        spinner = {},
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:env | grep GEMINI_API_KEY | awk -F= '{print $2}'",
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen3:latest",
              },
              num_ctx = {
                default = 20000,
              },
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              stream = true,
            },
            env = {
              api_key = "cmd:env | grep OPENAI_API_KEY | awk -F= '{print $2}'",
            },
            schema = {
              model = {
                default = function()
                  return "gpt-5"
                end,
              },
            },
          })
        end,
      },
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}
