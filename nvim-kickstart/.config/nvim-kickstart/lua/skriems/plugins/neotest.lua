return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      "nvim-neotest/neotest-plenary",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.tbl_deep_extend('force',
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      vim.tbl_deep_extend('force', opts.adapters, require("neotest-vitest"))
      vim.tbl_deep_extend('force', opts.adapters, require("neotest-plenary"))
    end,
  },
}
