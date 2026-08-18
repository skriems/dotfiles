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
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          env = { CI = true },
          cwd = function(path)
            return vim.fs.root(path, "package.json")
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(opts.adapters, require("neotest-plenary"))
    end,
  },
}
