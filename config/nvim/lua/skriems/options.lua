-- General
vim.opt.exrc = true                   -- use project local .exrc files (i.e for setting project local table helpers
vim.opt.history = 1000                -- How many lines of history to remember
vim.opt.undofile = true               -- Save undo history
vim.opt.undodir = vim.fn.expand("~") .. "/.vim/undodir" -- Save undo history in a separate directory
vim.opt.cf = true                     -- use custom filetypes
vim.opt.ffs = unix,mac,dos            -- file format syntaxes
-- vim.opt.viminfo = "~/.viminfo"        -- viminfo file
vim.opt.iskeyword:append("_,$,@,%,#,-")     -- keymap shortcuts
vim.opt.showbreak = ">"               -- show breakpoints
vim.opt.backspace = {"indent", "eol", "start"}  -- backspace behavior
vim.opt.autoread = true               -- realod on external writes
vim.opt.showmatch = true              -- show matching parens
vim.opt.mat = 5                       -- max number of matches to show
vim.opt.hlsearch = false              -- disable highlighting of search results
vim.opt.incsearch = true              -- highlight search results when typing
vim.opt.scrolloff = 5                 -- scroll offset
vim.opt.visualbell = true             -- visual bell
vim.opt.errorbells = false            -- no error bells
vim.opt.errorformat:append("%f|%l col %c|%m") -- error format
vim.opt.list = true
vim.opt.listchars = {tab = "▸ ", trail = "·"}
-- vim.opt.listchars = {eol = "↲", tab = "▸ ", trail = "·"}
vim.opt.splitright = true             -- split windows right
vim.opt.splitbelow = true             -- split windows below
vim.opt.wildignore = {"*/cache/*", "*/tmp/*"} -- ignore these files in wildcard searches

-- Tabstops
vim.opt.expandtab = true              -- expand tabs to spaces
vim.opt.tabstop = 4                   -- tabs produce 4 spaces
vim.opt.softtabstop = 4               -- overwrite locally
vim.opt.shiftwidth = 4                -- overwrite locally

-- expand tabs to spaces

-- Indentation
vim.opt.autoindent = true             -- auto indent on newline
vim.opt.smartindent = true            -- smart indent
vim.opt.number = true                 -- show line numbers
vim.opt.relativenumber = true         -- show relative line number
vim.opt.numberwidth = 3               -- width of "gutter"
-- vim.opt.cursorline = true             -- color column

-- Folding
vim.opt.foldenable = true             -- enable folding
vim.opt.foldmethod = "marker"           -- fold based on syntax
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 0                 -- don"t autofold
-- vim.opt.foldopen:remove("search")     -- don"t open folds when you search into them
-- vim.opt.foldopen:remove("undo")       -- don"t open folds when you undo stuff


vim.opt.grepprg = "rg --vimgrep"
vim.g.ctrlp_command = "rg --vimgrep %s"
vim.g.ctrlp_ignore_patterns = {"*/cache/*", "*/tmp/*"}
vim.g.ctrlp_use_caching = 0

-- ColorScheme

vim.o.termguicolors = true
vim.o.background = "dark"

-- global interpreters for nvim so that we don"t need to
-- "pip install neovim" in every virtualenv
vim.g.python3_host_prog = "$HOME/.virtualenvs/nvim3/bin/python"
vim.g.python_host_prog = "$HOME/.virtualenvs/nvim2/bin/python"
