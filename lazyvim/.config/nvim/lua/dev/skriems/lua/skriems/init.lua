local M = {}

M.opts = {
  notify_prefix = "skriems",
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

local function info(msg)
  vim.notify(string.format("[%s] %s", M.opts.notify_prefix, msg))
end

-- Autoload beim Start (oder via cmd/keys lazy-laden – siehe Spec)
vim.api.nvim_create_user_command("MyHello", function()
  require("skriems").hello()
end, { desc = "Say hello from myplugin" })

function M.hello()
  info("Hello from setup-aware skriems! 🎉")
end

return M
