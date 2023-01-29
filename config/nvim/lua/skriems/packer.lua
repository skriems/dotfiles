local has = function(x)
  return vim.fn.has(x) == 1
end

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

local is_mac = has "macunix"
local is_linux = not is_wsl and not is_mac

local max_jobs = nil
if is_mac then
  max_jobs = 32
end

-- install packer if not installed
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- :PackerCompile when plugins.lua is written
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function()
  use "wbthomason/packer.nvim" -- Packer can manage itself

  --
  -- LSP
  --
  use "neovim/nvim-lspconfig" -- Configurations for Nvim LSP
  use('simrat39/inlay-hints.nvim') -- Show type hints in the buffer

  if is_mac then
    use "williamboman/nvim-lsp-installer"
  end

  use "j-hui/fidget.nvim"
  use "onsails/lspkind-nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  use "jose-elias-alvarez/null-ls.nvim"

  use "folke/lsp-colors.nvim" -- creates missing diagnostics highlight groups for color schemes that don"t yet support builtin lsp client
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use {
    "folke/lsp-trouble.nvim",
    cmd = "Trouble",
    config = function()
      -- Can use P to toggle auto movement
      require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
      }
    end,
  }

  --
  -- Completion
  --
  use "github/copilot.vim"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  -- use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})

  use {
    "styled-components/vim-styled-components",
    branch = "main"
  }
  use "rhysd/vim-wasm"
  use "pantharshit00/vim-prisma"
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    cmd = "MarkdownPreview"
  }

  --
  -- UI
  --
  use {
    "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" },
    config = function() require("gitsigns").setup() end
  }
  use "nvim-lualine/lualine.nvim"
  use "rcarriga/nvim-notify"
  use "norcalli/nvim-colorizer.lua"

  --
  -- DAP
  --
  use "mfussenegger/nvim-dap"
  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"}
  }
  use {
    "theHamsta/nvim-dap-virtual-text",
    requires = { "nvim-treesitter/nvim-treesitter" }
  }
  use "nvim-telescope/telescope-dap.nvim"
  use "leoluz/nvim-dap-go"

  -- Node
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    commit = '008918b269b96934aa743361b1cd3f349c9eac8a'
    -- run = "npm install --legacy-peer-deps && npm run compile" 
  }

  --
  -- Telescope
  --
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }
  use "nvim-telescope/telescope-ui-select.nvim"
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Tools
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  }

  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-completion"
  use {
    "kristijanhusak/vim-dadbod-ui",
    config = function()
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_dotenv_variable_prefix = "DBUI_"
      vim.g.db_ui_save_location = "~/.config/nvim/dbui"
    end
  }
  use "potamides/pantran.nvim"
  use "windwp/nvim-autopairs"

  -- TODO
  -- Alternative to impatient, uses sqlite. Faster ;)
  -- use https://github.com/tami5/impatient.nvim
  -- use "lewis6991/impatient.nvim" -- speed up loading Lua modules in neovim to improve startup time

  use "tpope/vim-fugitive"
  use "tpope/vim-commentary"
  use "tpope/vim-dotenv"
  use "tpope/vim-surround"
  use "vifm/vifm.vim"

  -- use "mbbill/undotree"
  -- use "rhysd/git-messenger.vim"
  -- use "ziontee113/icon-picker.nvim"
  -- use "ziontee113/color-picker.nvim"

  -- for neovim development
  -- use "folke/neodev.nvim"

  use {
    "klesh/nvim-runscript",
    config = function() require("nvim-runscript").setup{} end
  }
  -- ColorScheme
  use "morhetz/gruvbox"
  use "EdenEast/nightfox.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
