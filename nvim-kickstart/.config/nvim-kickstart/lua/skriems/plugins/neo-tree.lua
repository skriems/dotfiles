local function on_file_remove(args)
  local ts_clients = vim.lsp.get_active_clients { name = 'tsserver' }
  for _, ts_client in ipairs(ts_clients) do
    ts_client.request('workspace/executeCommand', {
      command = '_typescript.applyRenameFile',
      arguments = {
        {
          sourceUri = vim.uri_from_fname(args.source),
          targetUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = 'Neotree',
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = function()
    local events = require 'neo-tree.events'

    local opts = {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      sources = { 'filesystem', 'buffers', 'git_status' },
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = false, -- used when sorting files and directories in the tree
      -- source_selector = {
      --   winbar = true,
      --   content_layout = 'center',
      --   sources = {
      --     { source = 'filesystem', display_name = get_icon('FolderClosed', 1, true) .. 'File' },
      --     { source = 'buffers', display_name = get_icon('DefaultFile', 1, true) .. 'Bufs' },
      --     { source = 'git_status', display_name = get_icon('Git', 1, true) .. 'Git' },
      --     { source = 'diagnostics', display_name = get_icon('Diagnostic', 1, true) .. 'Diagnostic' },
      --   },
      -- },
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰜌',
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '✖', -- this can only be used in the git_status source
            renamed = '󰁕', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = true,
          required_width = 64, -- min width of window required to show this column
        },
        type = {
          enabled = true,
          required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
          enabled = true,
          required_width = 88, -- min width of window required to show this column
        },
        created = {
          enabled = true,
          required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
          enabled = false,
        },
      },
      commands = {
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
            state.commands.open(state)
          end
        end,
      },
      window = {
        width = 30,
        mappings = {
          ['<space>'] = false, -- disable space until we figure out which-key disabling
          ['[b'] = 'prev_source',
          [']b'] = 'next_source',
          h = 'parent_or_close',
          l = 'child_or_open',
          o = 'open',
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ['<C-j>'] = 'move_cursor_down',
          ['<C-k>'] = 'move_cursor_up',
        },
      },
      nesting_rules = {},
      filesystem = {
        follow_current_file = { enabled = true, leave_dirs_open = false },
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = vim.fn.has 'win32' ~= 1,
      },
      event_handlers = {
        {
          event = events.NEO_TREE_BUFFER_ENTER,
          handler = function(_)
            vim.opt_local.signcolumn = 'auto'
          end,
        },
        { event = events.FILE_MOVED, handler = on_file_remove },
        { event = events.FILE_RENAMED, handler = on_file_remove },
      },
    }
    opts.commands.find_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == 'file' and node:get_parent_id() or node:get_id()
      require('telescope.builtin').find_files { cwd = path }
    end
    opts.window.mappings.F = 'find_in_dir'
    return opts
  end,
}
