local utils = require "astronvim.utils"

return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "codelldb",
        "chrome",
        "firefox",
        "js",
        "node2",
        "php",
        "python",
      })
      opts.automatic_installation = true
      -- -- print(vim.inspect(opts.handlers))
      -- opts.handlers = {
      --   js = function(config)
      --     config.configurations = {
      --       {
      --         name = "attach to process",
      --         type = "pwa-node",
      --         request = "attach",
      --         processId = function(...) return require("dap.utils").pick_process(...) end,
      --         cwd = "${workspaceFolder}",
      --       },
      --       {
      --         name = "attach to port",
      --         type = "pwa-node",
      --         request = "attach",
      --         port = function() return vim.fn.input("Port: ", "9229") end,
      --         localRoot = function() return vim.fn.input("Local Root: ", vim.fn.getcwd()) end,
      --         remoteRoot = function() return vim.fn.input("Remote root: ", "/application") end,
      --         cwd = "${workspaceFolder}",
      --         envFile = "${workspaceFolder}/.env",
      --       },
      --     }
      --     require("mason-nvim-dap").default_setup(config) -- don't forget this!
      --   end,
      -- }
    end,
    config = function(plugin, opts)
      -- print(vim.sinpect(opts))

      -- run the core AstroNvim configuration function with the options table
      require "plugins.configs.mason-nvim-dap"(plugin, opts)

      local dap = require "dap"

      -- just for reference: this is how you could get install paths and set adapters
      -- if we would not install them automatically
      --
      -- dap.adapters["pwa-node"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     args = {
      --       require("mason-registry").get_package("js-debug-adapter"):get_install_path()
      --         .. "/js-debug/src/dapDebugServer.js",
      --       "${port}",
      --     },
      --   },
      -- }

      local attach_process = {
        name = "js-debug-adapter: attach to process",
        type = "pwa-node",
        request = "attach",
        processId = function(...) return require("dap.utils").pick_process(...) end,
        cwd = "${workspaceFolder}",
      }

      local attach_port = {
        name = "js-debug-adapter: attach to port",
        type = "pwa-node",
        request = "attach",
        port = function() return vim.fn.input("Port: ", "9229") end,
        localRoot = function() return vim.fn.input("local root: ", vim.fn.getcwd()) end,
        remoteRoot = function() return vim.fn.input("remote root: ", "/application") end,
        cwd = "${workspaceFolder}",
        envFile = "${workspaceFolder}/.env",
      }

      utils.extend_tbl(dap.configurations.javascript, attach_port)
      utils.extend_tbl(dap.configurations.javascript, attach_process)
      utils.extend_tbl(dap.configurations.javascriptreact, attach_port)
      utils.extend_tbl(dap.configurations.javascriptreact, attach_process)
      utils.extend_tbl(dap.configurations.typescript, attach_port)
      utils.extend_tbl(dap.configurations.typescript, attach_process)
      utils.extend_tbl(dap.configurations.typescriptreact, attach_port)
      utils.extend_tbl(dap.configurations.typescriptreact, attach_process)
    end,
  },
}
