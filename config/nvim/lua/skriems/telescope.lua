-- Telescope
require("telescope").setup({
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
require("telescope").load_extension("notify")
require("telescope").load_extension("refactoring")
require("telescope").load_extension("ui-select")

-- Keybindings
-- NOTE to self: use <C-u> and <C-d> for scrolling the preview window
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
vim.keymap.set("n", "<leader>fib", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set("n", "<leader>fl", "<cmd>lua require('telescope.builtin').loclist()<CR>")
vim.keymap.set("n", "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<CR>")
vim.keymap.set("n", "<leader>fs", "<cmd>lua require('telescope.builtin').spell_suggest()<CR>")
vim.keymap.set("n", "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<CR>")
vim.keymap.set("n", "<leader>F", "<cmd>lua require('telescope.builtin').grep_string()<CR>")
vim.keymap.set("n", "<leader>fv", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>gg", ":G<CR>", { desc = "open vim-fugitive" })
vim.keymap.set("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
vim.keymap.set("n", "<leader>gbc", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>")
vim.keymap.set("n", "<leader>gst", "<cmd>lua require('telescope.builtin').git_stash()<CR>")
-- extensions
vim.keymap.set("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", opts)
vim.keymap.set("v", "<leader>rf", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })

