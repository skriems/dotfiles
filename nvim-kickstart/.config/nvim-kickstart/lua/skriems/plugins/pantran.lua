return {
  'potamides/pantran.nvim',
  lazy = true,
  cmd = { 'Pantran' },
  keys = {
    { mode = 'n', "<leader>tr", function() require('pantran').motion_translate() end, desc = "Pantran: Motion Translate"},
    { mode = 'n', "<leader>trr", function() return require('pantran').motion_translate() .. "_" end, desc = "Pantran: Motion Translate"},
    { mode = 'x', "<leader>tr", function() require('pantran').motion_translate() end, desc = "Pantran: Motion Translate"},
  }
}
