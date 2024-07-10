return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  keys = {
    {
      mode = 'n',
      '<leader>xx',
      function()
        require('trouble').toggle()
      end,
      desc = 'Trouble',
    },
    {
      mode = 'n',
      '<leader>xw',
      function()
        require('trouble').toggle 'workspace_diagnostics'
      end,
      desc = 'Trouble workspave diagnostics',
    },
    {
      mode = 'n',
      '<leader>xd',
      function()
        require('trouble').toggle 'document_diagnostics'
      end,
      desc = 'Trouble document diagnostics',
    },
    {
      mode = 'n',
      '<leader>xq',
      function()
        require('trouble').toggle 'quickfix'
      end,
      desc = 'Trouble quickfix',
    },
    {
      mode = 'n',
      '<leader>xl',
      function()
        require('trouble').toggle 'loclist'
      end,
      desc = 'Trouble loclist',
    },
  },
}
