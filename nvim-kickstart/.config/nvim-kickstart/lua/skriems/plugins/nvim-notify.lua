return {
  'rcarriga/nvim-notify',
  -- lazy = true,
  opts = {
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    end,
  },
  config = function(_, opts)
    local notify = require 'notify'
    notify.setup(opts)
    vim.notify = notify
  end,
}
