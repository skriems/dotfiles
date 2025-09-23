return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '▎' },
      topdelete = { text = '▎' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
  },
  keys = {
    {
      mode = 'n',
      ']g',
      function()
        require('gitsigns').next_hunk()
      end,
      desc = 'Next Git hunk',
    },
    {
      mode = 'n',
      '[g',
      function()
        require('gitsigns').prev_hunk()
      end,
      desc = 'Previous Git hunk',
    },
    {
      mode = 'n',
      '<leader>gl',
      function()
        require('gitsigns').blame_line()
      end,
      desc = 'View Git blame',
    },
    {
      mode = 'n',
      '<leader>gL',
      function()
        require('gitsigns').blame_line { full = true }
      end,
      desc = 'View full Git blame',
    },
    {
      mode = 'n',
      '<leader>gp',
      function()
        require('gitsigns').preview_hunk()
      end,
      desc = 'Preview Git hunk',
    },
    {
      mode = 'n',
      '<leader>gh',
      function()
        require('gitsigns').reset_hunk()
      end,
      desc = 'Reset Git hunk',
    },
    {
      mode = 'n',
      '<leader>gr',
      function()
        require('gitsigns').reset_buffer()
      end,
      desc = 'Reset Git buffer',
    },
    {
      mode = 'n',
      '<leader>gs',
      function()
        require('gitsigns').stage_hunk()
      end,
      desc = 'Stage Git hunk',
    },
    {
      mode = 'n',
      '<leader>gS',
      function()
        require('gitsigns').stage_buffer()
      end,
      desc = 'Stage Git buffer',
    },
    {
      mode = 'n',
      '<leader>gu',
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      desc = 'Unstage Git hunk',
    },
    {
      mode = 'n',
      '<leader>gd',
      function()
        require('gitsigns').diffthis()
      end,
      desc = 'View Git diff',
    },
    {
      mode = 'n',
      '<leader>gb',
      function()
        require('telescope.builtin').git_branches { use_file_path = true }
      end,
      desc = 'Git branches',
    },
    {
      mode = 'n',
      '<leader>gc',
      function()
        require('telescope.builtin').git_commits { use_file_path = true }
      end,
      desc = 'Git commits',
    },
    {
      mode = 'n',
      '<leader>gC',
      function()
        require('telescope.builtin').git_bcommits { use_file_path = true }
      end,
      desc = 'Git commits (current buffer)',
    },
    {
      mode = 'n',
      '<leader>gt',
      function()
        require('telescope.builtin').git_status { use_file_path = true }
      end,
      desc = 'Git status',
    },
  },
}
