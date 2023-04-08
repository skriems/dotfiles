require("dapui").setup()

require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = false,  -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
  highlight_changed_variables = true,  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true,
  commented = false,  -- prefix virtual text with comment string
  show_stop_reason = true,
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
})

-- env = function()
--   local variables = {}
--   for k, v in pairs(vim.fn.environ()) do
--     table.insert(variables, string.format("%s=%s", k, v))
--   end
--   return variables
-- end

--
-- Go
--
-- require("dap-go").setup()

-- open and close dapui
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--
-- Rust
--
-- dap.adapters.lldb = {
--   type = "executable",
--   command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
--   name = "lldb"
-- }

-- You can attach debuggers to existing processes. First, launch rust-lldb with the path to the exact binary in use. If you’re compiling in dev mode for this (recommended), make sure LanguageClient is actually using that binary. Don’t use the run command. Find the process id of ra_lsp_server and use the process attach -p 123 command after setting some breakpoints.
-- dap.configurations.rust = {
--   {
--     name = "Launch file",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Program: ", os.getenv("CARGO_TARGET_DIR") .. "/debug/", "file")
--     end,
--     args = function()
--       return vim.fn.input("args: ", "", "file")
--     end,
--     runtimeArgs = function ()
--       return vim.fn.input("runtime args: ", "", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     runInTerminal = false,
--     stopOnEntry = false,
--     -- inherit env variables from the parent for lldb-vscode
--     env = function()
--       local variables = {}
--       for k, v in pairs(vim.fn.environ()) do
--         table.insert(variables, string.format("%s=%s", k, v))
--       end
--       return variables
--     end,
--   },
--   {
--     name = "cargo test",
--     type = "lldb",
--     request = "launch",
--     program = "cargo",
--     args = function()
--       return vim.fn.input("args: ", "", "file")
--     end,
--     runtimeArgs = function ()
--       return vim.fn.input("runtime args: ", "", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     runInTerminal = false,
--     stopOnEntry = false,
--     -- inherit env variables from the parent for lldb-vscode
--     env = function()
--       local variables = {}
--       for k, v in pairs(vim.fn.environ()) do
--         table.insert(variables, string.format("%s=%s", k, v))
--       end
--       return variables
--     end,
--   },
-- }

--
-- Node
--
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = "Attach to port 9229",
      type = "pwa-node",
      request = "attach",
      port = "9229",
      -- port = function ()
      --   return vim.fn.input("Port: ", 9229)
      -- end,
      -- localRoot = "${workspaceFolder}",
      localRoot = function ()
        return vim.fn.input("Local Root: ", vim.fn.getcwd())
      end,
      -- remoteRoot = "/application",
      remoteRoot = function ()
        return vim.fn.input("Remote root: ", "/application")
      end,
      cwd = "${workspaceFolder}",
      envFile = "${workspaceFolder}/.env",
    },
    {
      name = "Attach to process",
      type = "pwa-node",
      request = "attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      envFile = "${workspaceFolder}/.env",
    },
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      name = "debug jest tests",
      type = "pwa-node",
      request = "launch",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end
