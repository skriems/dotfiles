return {
  "saghen/blink.cmp",
  dependencies = { "moyiz/blink-emoji.nvim" },
  opts = function(_, opts)
    table.insert(opts.sources.default, "emoji")
    opts.sources.providers.emoji = {
      module = "blink-emoji",
      name = "Emoji",
      score_offset = 15,
      opts = { insert = true },
    }
  end,
}
