local js_filetypes = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}

return {
  "mfussenegger/nvim-dap",
  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(LazyVim.config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    for _, ft in ipairs(js_filetypes) do
      require("dap").configurations[ft] = {
        -- {
        --   type = "pwa-node",
        --   request = "attach",
        --   name = "attach to repl",
        --   port = 9231,
        --   localRoot = "${workspaceFolder}",
        --   remoteRoot = "/code",
        -- },
        -- {
        --   type = "pwa-node",
        --   request = "attach",
        --   name = "attach remote /code on port 9229",
        --   port = 9229,
        --   localRoot = "${workspaceFolder}",
        --   remoteRoot = "/code",
        -- },
        {
          type = "pwa-node",
          request = "attach",
          name = "attach to inspector (remoteRoot: /code)",
          port = function()
            return vim.fn.input("Port", "9229")
          end,
          localRoot = "${workspaceFolder}",
          remoteRoot = "/code",
          -- remoteRoot = function()
          --   return vim.fn.input("remoteRoot", "/code")
          -- end,
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

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    local json = require("plenary.json")
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end

    -- Extends dap.configurations with entries read from .vscode/launch.json
    if vim.fn.filereadable(".vscode/launch.json") then
      vscode.load_launchjs()
    end
  end,
}
