local js_filetypes = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}

return {
  "mfussenegger/nvim-dap",
  init = function()
    LazyVim.on_load("nvim-dap", function()
      local dap = require("dap")
      for _, ft in ipairs(js_filetypes) do
        vim.list_extend(dap.configurations[ft], {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch node (inspect-brk)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = { "--inspect-brk=9229" },
            console = "integratedTerminal",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to inspector (remote root)",
            port = function()
              return vim.fn.input("Port", "9229")
            end,
            localRoot = "${workspaceFolder}",
            remoteRoot = function()
              return vim.fn.input("Remote root", "/code")
            end,
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({ prompt = "Enter URL:", default = "http://localhost:3000" }, function(url)
                  if url and url ~= "" then
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = "${workspaceFolder}",
            skipFiles = { "<node_internals>/**/*.js" },
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
        })
      end
    end)
  end,
}
