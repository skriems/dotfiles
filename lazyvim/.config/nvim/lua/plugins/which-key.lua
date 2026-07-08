return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    require("which-key").add({ "<leader>a", group = "AI", desc = "AI" })
    require("which-key").add({ "<leader>ao", group = "opencode", desc = "opencode" })
  end,
}
