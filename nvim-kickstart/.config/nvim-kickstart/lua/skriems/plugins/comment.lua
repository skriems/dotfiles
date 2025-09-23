return {
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  lazy = false,
  keys = {
    {
      '<leader>/',
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      mode = 'v',
      desc = 'Toggle comment for selection',
    },
  },
  opts = {},
}
