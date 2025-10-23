-- https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/noice.nvim",
    },
    init = function()
      require("dev.companion-notify").init()
    end,
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
        -- spinner = {},
      },
      strategies = {
        chat = {
          name = "copilot",
          model = "gpt-5-codex",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
      adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              env = {
                GEMINI_API_KEY = "cmd:env | grep GEMINI_API_KEY | awk -F= '{print $2}'",
              },
            })
          end,
          code = function()
            return {
              name = "code",
              formatted_name = "Code",
              type = "acp",
              roles = {
                llm = "assistant",
                user = "user",
              },
              opts = {
                vision = true,
              },
              commands = {
                default = {
                  "npx",
                  "-y",
                  "@just-every/code",
                  "acp",
                },
              },
              parameters = {
                protocolVersion = 1,
                clientCapabilities = {
                  fs = { readTextFile = true, writeTextFile = true },
                },
                clientInfo = {
                  name = "CodeCompanion.nvim",
                  version = "1.0.0",
                },
              },
              handlers = {
                ---@param self CodeCompanion.ACPAdapter
                ---@return boolean
                setup = function(self)
                  return true
                end,

                ---@param self CodeCompanion.ACPAdapter
                ---@param messages table
                ---@param capabilities table
                ---@return table
                form_messages = function(self, messages, capabilities)
                  local helpers = require("codecompanion.adapters.acp.helpers")
                  return helpers.form_messages(self, messages, capabilities)
                end,

                ---Function to run when the request has completed. Useful to catch errors
                ---@param self CodeCompanion.ACPAdapter
                ---@param code number
                ---@return nil
                on_exit = function(self, code) end,
              },
            }
          end,
        },
        http = {
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
                  default = "gpt-oss:latest",
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
                    return "gpt-5-mini"
                  end,
                },
              },
            })
          end,
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanionChat" })
      vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CompanionChat Action Palette" })
    end,
  },
}
