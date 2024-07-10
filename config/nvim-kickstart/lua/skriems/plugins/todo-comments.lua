return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = vim.g.have_nerd_font },
  keys = {
    { '<leader>T', '<cmd>TodoTelescope<cr>', desc = 'Open TODOs' },
  },
}
