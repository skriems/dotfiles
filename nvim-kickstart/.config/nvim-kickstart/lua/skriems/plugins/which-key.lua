return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local utils = require 'skriems.utils'
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = utils.get_icon('Debugger', 1, true) .. 'DAP', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = utils.get_icon('ActiveLSP', 1, true) .. 'LSP', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = utils.get_icon('Git', 1, true) .. 'Git', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = utils.get_icon('Search', 1, true) .. 'Search', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = utils.get_icon('Package', 1, true) .. 'Plugins', _ = 'which_key_ignore' },
    }
  end,
}
