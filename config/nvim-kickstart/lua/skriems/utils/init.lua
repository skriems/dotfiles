local M = {}

local allTerms = {}

function M.cmd(cmd, show_error)
  if type(cmd) == 'string' then
    cmd = { cmd }
  end
  if vim.fn.has 'win32' == 1 then
    cmd = vim.list_extend({ 'cmd.exe', '/C' }, cmd)
  end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar 'shell_error' == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_err_writeln(('Error running command %s\nError message:\n%s'):format(table.concat(cmd, ' '), result))
  end
  return success and result:gsub('[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]', '') or nil
end

--- Toggle a user terminal if it exists, if not then create a new one and save it
---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
function M.toggle_term_cmd(opts)
  local terms = allTerms
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == 'string' then
    opts = { cmd = opts, hidden = true }
  end
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then
    terms[opts.cmd] = {}
  end
  if not terms[opts.cmd][num] then
    if not opts.count then
      opts.count = vim.tbl_count(terms) * 100 + num
    end
    if not opts.on_exit then
      opts.on_exit = function()
        terms[opts.cmd][num] = nil
      end
    end
    terms[opts.cmd][num] = require('toggleterm.terminal').Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

--- Get the first worktree that a file belongs to
---@param file string? the file to check, defaults to the current file
---@param worktrees table<string, string>[]? an array like table of worktrees with entries `toplevel` and `gitdir`, default retrieves from `vim.g.git_worktrees`
---@return table<string, string>|nil # a table specifying the `toplevel` and `gitdir` of a worktree or nil if not found
function M.file_worktree(file, worktrees)
  worktrees = worktrees or vim.g.git_worktrees
  if not worktrees then
    return
  end
  file = file or vim.fn.expand '%'
  for _, worktree in ipairs(worktrees) do
    if
      require('skriems.utils').cmd({
        'git',
        '--work-tree',
        worktree.toplevel,
        '--git-dir',
        worktree.gitdir,
        'ls-files',
        '--error-unmatch',
        file,
      }, false)
    then
      return worktree
    end
  end
end

--- Insert one or more values into a list like table and maintain that you do not insert non-unique values (THIS MODIFIES `lst`)
---@param lst any[]|nil The list like table that you want to insert into
---@param vals any|any[] Either a list like table of values to be inserted or a single value to be inserted
---@return any[] # The modified list like table
function M.list_insert_unique(lst, vals)
  if not lst then
    lst = {}
  end
  assert(vim.tbl_islist(lst), 'Provided table is not a list like table')
  if not vim.tbl_islist(vals) then
    vals = { vals }
  end
  local added = {}
  vim.tbl_map(function(v)
    added[v] = true
  end, lst)
  for _, val in ipairs(vals) do
    if not added[val] then
      table.insert(lst, val)
      added[val] = true
    end
  end
  return lst
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.close_buffer(bufnr, force)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  require('mini.bufremove').delete(bufnr, force)
end

function M.json_key_exists(filename, key)
  -- Open the file in read mode
  local file = io.open(filename, 'r')
  if not file then
    return false -- File doesn't exist or cannot be opened
  end

  -- Read the contents of the file
  local content = file:read '*all'
  file:close()

  -- Parse the JSON content
  local json_parsed, json = pcall(vim.fn.json_decode, content)
  if not json_parsed or type(json) ~= 'table' then
    return false -- Invalid JSON format
  end

  -- Check if the key exists in the JSON object
  return json[key] ~= nil
end

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
function M.get_icon(kind, padding, no_fallback)
  if not vim.g.have_nerd_font and no_fallback then
    return ''
  end
  local icon_pack = vim.g.have_nerd_font and 'icons' or 'text_icons'
  if not M[icon_pack] then
    M.icons = require 'skriems.icons.nerd'
    M.text_icons = require 'skriems.icons.text'
  end
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(' ', padding or 0) or ''
end

return M
