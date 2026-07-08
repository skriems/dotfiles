local js_filetypes = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}


return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local utils = require 'skriems.utils'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
      -- automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more ifalsenformation
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        'codelldb',
        'js',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    for _, ft in ipairs(js_filetypes) do
      dap.configurations[ft] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          -- Launch current file with node and the inspector enabled.
          -- This starts node under the debug adapter (no manual --inspect needed).
          type = "pwa-node",
          request = "launch",
          name = "Launch node (inspect-brk)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = { "--inspect-brk=9229" }, -- change to --inspect to not break on first line
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "attach to inspector (remoteRoot: /code)",
          port = function()
            return vim.fn.input("Port", "9229")
          end,
          localRoot = "${workspaceFolder}",
          -- remoteRoot = "/code",
          remoteRoot = function()
            return vim.fn.input("remoteRoot", "/code")
          end,
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "launch chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL:", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**/*.js" },
          protocol = "inspector",
          soureMaps = true,
          userDataDir = false,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dq', dap.close, { desc = 'Debug: Close' })
    vim.keymap.set('n', '<leader>dQ', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: REPL' })
    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Debug: Run To Cursor' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    if utils.is_available 'nvim-dap-ui' then
      vim.keymap.set('n', '<leader>de', function()
        dapui.eval(vim.fn.input 'Expression: ', { enter = true })
      end, { desc = 'Debug: Evaluate Expression' })
      vim.keymap.set('n', '<leader>dE', dapui.eval, { desc = 'Debug: Evaluate Input' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
      vim.keymap.set('n', '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Debug: Hover' })
    end

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
  end,
}
