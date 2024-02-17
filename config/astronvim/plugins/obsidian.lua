return {
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  event = { "BufReadPre  */nextcloud/docs/wiki/**.md" },
  keys = {
    {
      "gf",
      function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end,
      noremap = false,
      expr = true,
    },
  },
  opts = {
    dir = vim.env.HOME .. "/obsidian-vault",
    use_advanced_uri = true,
    finder = "telescope.nvim",
    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "notes",
    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
    log_level = vim.log.levels.DEBUG,

    -- Optional, completion.
    completion = {
      -- If using nvim-cmp, otherwise set to false
      nvim_cmp = true,
      -- Trigger completion at 2 chars
      min_chars = 2,
      -- Where to put new notes created from completion. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "current_dir",

      -- Whether to add the output of the node_id_func to new notes in autocompletion.
      -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
      prepend_note_id = true,
    },

    -- Optional, key mappings.
    mappings = {},
    -- mappings = {
    --   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
    -- },

    -- Optional, for templates (see below).
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
  },
}
