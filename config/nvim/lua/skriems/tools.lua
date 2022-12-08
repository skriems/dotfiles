require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, {expr=true})

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, {expr=true})

    -- Actions
    map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function() gs.blame_line{full=true} end)
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function() gs.diffthis("~") end)
    map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
})

require("lualine").setup({ options = { theme = "nordfox" } })

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

require("nvim-autopairs").setup({})

require("pantran").setup({
  default_engine = "deepl",
  engines = {
    deepl = {
      auth_key = "87999240-45b7-2da1-15ad-0725414d090a:fx",
      free_api = true
    }
  }
})

require("refactoring").setup({})

require("trouble").setup({})

require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "italic",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...Hello
    },
  }
})

-- setup nvim-notify and use it for notifications globally
local notify = require('notify')
notify.setup({
  background_colour = "#000000",
  render = "minimal",
  stages = "fade"
})

vim.notify = notify

-- nvim-colorizer
require('colorizer').setup()

require('nvim-tree').setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 40,
    side = 'left',
    mappings = {
      list = {
        { key = "h", action = "close_node" },
        { key = "l", action = "edit" },
      }
    },
    number = true,
    relativenumber = true,
  }
})
