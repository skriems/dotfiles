local utils = require 'skriems.utils'

return {
  'akinsho/toggleterm.nvim',
  opts = {},
  config = function()
    if vim.fn.executable 'lazygit' == 1 then
      vim.keymap.set('n', '<leader>gg', function()
        local worktree = utils.file_worktree()
        local flags = worktree and (' --work-tree=%s --git-dir=%s'):format(worktree.toplevel, worktree.gitdir) or ''
        utils.toggle_term_cmd { cmd = 'lazygit ' .. flags, direction = 'float' }
      end, { desc = 'Lazygit' })
    end
    if vim.fn.executable 'node' == 1 then
      vim.keymap.set('n', '<leader>tn', function()
        utils.toggle_term_cmd 'node'
      end, { desc = 'ToggleTerm node' })
    end
    local gdu = vim.fn.has 'mac' == 1 and 'gdu-go' or 'gdu'
    if vim.fn.executable(gdu) == 1 then
      vim.keymap.set('n', '<leader>tu', function()
        utils.toggle_term_cmd(gdu)
      end, { desc = 'ToggleTerm gdu' })
    end
    if vim.fn.executable 'btm' == 1 then
      vim.keymap.set('n', '<leader>tt', function()
        utils.toggle_term_cmd { cmd = 'btm', direction = 'float' }
      end, { desc = 'ToggleTerm btm' })
    end

    -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    -- is not what someone will guess without a bit more experience.
    --
    -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    -- or just use <C-\><C-n> to exit terminal mode
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    -- TIP: Disable arrow keys in normal mode
    -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
    -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
    -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
    -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

    -- Keybinds to make split navigation easier.
    --  Use CTRL+<hjkl> to switch between windows
    --
    --  See `:help wincmd` for a list of all window commands
    -- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    -- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    -- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    -- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  end,
}
