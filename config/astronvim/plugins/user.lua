return {
  -- You can also add new plugins here as well:
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- config = function()
    --   require("todo-comments").setup {}
    -- end,
    event = "User AstroFile",
    cmd = { "TodoQuickFix" },
    opts = {},
    keys = {
      { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs" },
    },
  },
  {
    "potamides/pantran.nvim",
    event = "User AstroFile",
    cmd = { "Pantran" },
    -- vim.keymap.set("n", "<leader>tr", pantran.motion_translate, opts)
    -- vim.keymap.set("n", "<leader>trr", function() return pantran.motion_translate() .. "_" end, opts)
    -- vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "User AstroFile",
    dependencies = {
      {
        "microsoft/vscode-js-debug",
        config = function() end,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && git checkout -- .",
      },
    },
    opts = {
      debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
      -- adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      -- adapters = { "pwa-node" },
    },
    -- config = function(plugin, opts)
    --   require "plugins.configs.mason-nvim-dap"(plugin, opts)
    --   local dap = require "dap"
    --   local attach_process = {
    --     type = "pwa-node",
    --     request = "attach",
    --     name = "attach to process",
    --     processId = function(...) return require("dap.utils").pick_process(...) end,
    --     cwd = "${workspaceFolder}",
    --   }
    --
    --   local attach_port = {
    --     name = "attach to port",
    --     type = "pwa-node",
    --     request = "attach",
    --     port = function() return vim.fn.input("Port: ", "9229") end,
    --     localRoot = function() return vim.fn.input("Local Root: ", vim.fn.getcwd()) end,
    --     remoteRoot = function() return vim.fn.input("Remote root: ", "/application") end,
    --     cwd = "${workspaceFolder}",
    --     envFile = "${workspaceFolder}/.env",
    --   }
    --   dap.configurations.javascript = {
    --     attach_process,
    --     attach_port,
    --   }
    --   dap.configurations.typescript = {
    --     attach_process,
    --     attach_port,
    --   }
    -- end,
  },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   event = { "BufReadPre ~/obsidian--vault/**.md" },
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  --   -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --
  --     -- see below for full list of optional dependencies 👇
  --   },
  --   opts = {
  --     -- Required, the path to your vault directory.
  --     dir = "~/obsidian--vault",
  --
  --     -- Optional, if you keep notes in a specific subdirectory of your vault.
  --     notes_subdir = "notes",
  --
  --     -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
  --     -- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
  --     log_level = vim.log.levels.DEBUG,
  --
  --     daily_notes = {
  --       -- Optional, if you keep daily notes in a separate directory.
  --       folder = "notes/dailies",
  --       -- Optional, if you want to change the date format for daily notes.
  --       date_format = "%Y-%m-%d",
  --     },
  --
  --     -- Optional, completion.
  --     completion = {
  --       -- If using nvim-cmp, otherwise set to false
  --       nvim_cmp = true,
  --       -- Trigger completion at 2 chars
  --       min_chars = 2,
  --       -- Where to put new notes created from completion. Valid options are
  --       --  * "current_dir" - put new notes in same directory as the current buffer.
  --       --  * "notes_subdir" - put new notes in the default notes subdirectory.
  --       new_notes_location = "current_dir",
  --
  --       -- Whether to add the output of the node_id_func to new notes in autocompletion.
  --       -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
  --       prepend_note_id = true,
  --     },
  --
  --     -- Optional, key mappings.
  --     mappings = {
  --       -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
  --       ["gf"] = require("obsidian.mapping").gf_passthrough(),
  --     },
  --
  --     -- Optional, customize how names/IDs for new notes are created.
  --     note_id_func = function(title)
  --       -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
  --       -- In this case a note with the title 'My new note' will given an ID that looks
  --       -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
  --       local suffix = ""
  --       if title ~= nil then
  --         -- If title is given, transform it into valid file name.
  --         suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  --       else
  --         -- If title is nil, just add 4 random uppercase letters to the suffix.
  --         for _ = 1, 4 do
  --           suffix = suffix .. string.char(math.random(65, 90))
  --         end
  --       end
  --       return tostring(os.time()) .. "-" .. suffix
  --     end,
  --
  --     -- Optional, set to true if you don't want obsidian.nvim to manage frontmatter.
  --     disable_frontmatter = false,
  --
  --     -- Optional, alternatively you can customize the frontmatter data.
  --     note_frontmatter_func = function(note)
  --       -- This is equivalent to the default frontmatter function.
  --       local out = { id = note.id, aliases = note.aliases, tags = note.tags }
  --       -- `note.metadata` contains any manually added fields in the frontmatter.
  --       -- So here we just make sure those fields are kept in the frontmatter.
  --       if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
  --         for k, v in pairs(note.metadata) do
  --           out[k] = v
  --         end
  --       end
  --       return out
  --     end,
  --
  --     -- Optional, for templates (see below).
  --     templates = {
  --       subdir = "templates",
  --       date_format = "%Y-%m-%d-%a",
  --       time_format = "%H:%M",
  --     },
  --
  --     -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  --     -- URL it will be ignored but you can customize this behavior here.
  --     follow_url_func = function(url)
  --       -- Open the URL in the default web browser.
  --       vim.fn.jobstart { "open", url } -- Mac OS
  --       -- vim.fn.jobstart({"xdg-open", url})  -- linux
  --     end,
  --
  --     -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  --     -- https://github.com/Vinzent03/obsidian-advanced-uri
  --     use_advanced_uri = true,
  --
  --     -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  --     open_app_foreground = false,
  --
  --     -- Optional, by default commands like `:ObsidianSearch` will attempt to use
  --     -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
  --     -- first one they find. By setting this option to your preferred
  --     -- finder you can attempt it first. Note that if the specified finder
  --     -- is not installed, or if it the command does not support it, the
  --     -- remaining finders will be attempted in the original order.
  --     finder = "telescope.nvim",
  --   },
  -- },
}
