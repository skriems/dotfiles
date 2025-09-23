return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
    local git = statusline.section_git { trunc_width = 75 }
    local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
    local filename = statusline.section_filename { trunc_width = 140 }
    local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
    local location = statusline.section_location { trunc_width = 75 }
    local search = statusline.section_searchcount { trunc_width = 75 }

    statusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location } },
    }

    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    --  tabline
    local tabline = require 'mini.tabline'
    tabline.setup { show_icons = vim.g.have_nerd_font }

    -- require('mini.animate').setup {}
    require('mini.pairs').setup {}
  end,
}
