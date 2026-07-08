return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for default `toggle()` implementation.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "x" }, "<leader>aoa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>aox", function()
      require("opencode").select()
    end, { desc = "execute opencode action…" })
    vim.keymap.set({ "n", "x" }, "<leader>aoga", function()
      require("opencode").prompt("@this")
    end, { desc = "add to opencode" })
    vim.keymap.set({ "n", "t" }, "<leader>aot", function()
      require("opencode").toggle()
    end, { desc = "toggle opencode" })
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "opencode half page up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "opencode half page down" })
    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
  end,
}
