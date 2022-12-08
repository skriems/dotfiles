require("dapui").setup()
require("nvim-dap-virtual-text").setup()

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
require("dap-go").setup()

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
dap.adapters.lldb = {
  type = "executable",
  command = "/Users/skriems/.cargo/bin/rust-lldb",
  name = "lldb"
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    -- program = "/Users/skriems/.cargo/bin/cargo",
    program = function()
      -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      return vim.fn.input("Path to executable: ", os.getenv("CARGO_TARGET_DIR") .. "debug/", "file")
    end,
    args = {"eval", "AsKs", "JhKh"},
    -- runtimeArgs = function ()
    --   return vim.fn.input("Runtime args: ", "", "file")
    -- end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

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
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      name = "Attach",
      type = "pwa-node",
      request = "attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Debug Jest Tests",
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
    {
      name = "zeou-gateway",
      type = "pwa-node",
      request = "attach",
      port = 9221,
      localRoot = "${workspaceFolder}/source/services/gateway-service",
      remoteRoot = "/application",
      protocol = "inspector"
    },
    {
      name = "zeou-api",
      type = "pwa-node",
      request = "attach",
      port = 9222,
      localRoot = "${workspaceFolder}/source/services/api-service",
      remoteRoot = "/application",
      protocol = "inspector"
    },
    {
      name = "zeou-worker",
      type = "pwa-node",
      request = "attach",
      port = 9223,
      localRoot = "${workspaceFolder}/source/services/worker",
      remoteRoot = "/application",
      protocol = "inspector"
    },
  }
end
