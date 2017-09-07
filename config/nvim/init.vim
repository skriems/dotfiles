set nocompatible
filetype off

" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" snipMate
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'

Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'

" syntax and style
Plug 'sickill/vim-monokai'
Plug 'mhartington/oceanic-next'
Plug 'vim-python/python-syntax'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'  " show git branch

"typescript
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'

" Emmet
Plug 'mattn/emmet-vim'

" virtualenv
Plug 'jmcantrell/vim-virtualenv'

"NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'nvie/vim-flake8'

"""""""""""""""""""""""
" NEOVIM ONLY
"""""""""""""""""""""""
" Terminal/REPL
Plug 'kassio/neoterm'
" Jedi
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'  " NVIM
" Neomake
Plug 'neomake/neomake'

"""""""""""""""""""""""
" VIM ONLY
"""""""""""""""""""""""
" Jedi
" Plug 'davidhalter/jedi-vim'  " VIM


call plug#end()

syntax on  " enables standard syntax
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:flake8_show_in_gutter = 1
" call flake8#Flake8UnplaceMarkers()
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tagbar#enabled = 0

" use emmet only in html and css files
let g:user_emmet_install_global = 0
autocmd FileType html,css,ts EmmetInstall
"""""""""""""""""""""""
" NEOVIM ONLY
"""""""""""""""""""""""

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
" setup extra paths with
" let g:deoplete#sources#jedi#extra_path=
"
" Neoterm
" let g:neoterm_position = 'vertical' " set the neoterm pos to vertical
let g:neoterm_size=10

" run Neomake on ever write
autocmd! BufWritePost * Neomake
" 'pip install --no-deps --upgrade .' maker
" let g:neomake_pipnodeps_maker = {'exe': 'pip', 'args': ['install --no-deps --upgrade .']}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000 " How many lines of history to remember

" use the clipboard even in terminal
" NOTE: for nvim: install xsel to have the system clipboard
" available at "+" or "*" registers
" set clipboard+=unnamed " VIM only!

set cf " enable error files and error jumping
set ffs=unix,mac,dos " support all three, in this order
set viminfo+=!  " make sure it can save viminfo
set isk+=_,$,@,%,#,- " none of these should be word dividers, so make them not be
set sbr=> " show wrapped lines:
set backspace=indent,eol,start " Allow backspace in insert mode
" realod on external writes
set autoread

"""""""""""""""""""""""""""""""""
" Style
"""""""""""""""""""""""""""""""""
" Syntax
syntax enable  " enables specific syntax
" For Vim < 8
" set t_Co=256

" For Neovim 0.1.3 and 0.1.4
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" For Neovim >= 0.1.5 or Vim > 8
if (has("termguicolors"))
  set termguicolors
endif

" allow italics (VIM only)
" set t_ZH=[3m      " INSERT mode: <ctrl>+v<esc>
" set t_ZR=[23m

colorscheme OceanicNext
let g:airline_theme='oceanicnext'
" colorscheme monokai
" let g:airline_theme='wombat'

" highligh all from vim-python/python-syntax
let g:python_highlight_all = 1
highlight link pythonNone Boolean
highlight Statement cterm=italic gui=italic
highlight Conditional cterm=italic gui=italic
highlight Operator cterm=italic gui=italic
highlight Identifier cterm=italic gui=italic

" transparent background
highlight Normal ctermbg=None guibg=None
highlight NonText ctermbg=None guibg=None

" load html/css/js/jQuery scope when qsl scope is activated
" with :SnipMateLoadScope
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['qsl'] = 'html,css,javascript,javascript-jquery'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" searching
" show matching brackets
set showmatch
" how many tenths of a second to blink matching brackets for
set mat=5

" do not highlight search for phrases
set nohlsearch
" BUT do highlight as you type your search phrase
set incsearch

set columns=80 " 80 cols wide
set so=5 " Keep 5 lines (top/bottom) for scope

set visualbell " do blink
set noerrorbells " no noises

" show whitelist
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" always show the status line
set laststatus=2
" show branch via fugitive
set statusline+=%{fugitive#statusline()}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autoindent
set ai
" smartindent
set si
" do c-style indenting
set cindent
" show line numbers
set number
" show relative line number
set relativenumber
" width of 'gutter'
set numberwidth=2
" expand <CR>
let delimitMate_expand_cr = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global interpreters for nvim so that we don't need to 
" 'pip install neovim' in every virtualenv
let g:python3_host_prog = '/home/skr/.virtualenvs/nvim3/bin/python'
let g:python_host_prog = '/home/skr/.virtualenvs/nvim2/bin/python'

augroup python
    au!
    au BufNewFile /**/*.py 0r ~/.vim/skeleton/python.py|norm G
    au FileType python set textwidth=79
    au FileType python set omnifunc=pythoncomplete#Complete
    " au FileType python set relativenumber
    au FileType python set number
    au FileType python nnoremap <buffer> <localleader>c I#<esc>
    " au FileType python IndentGuidesEnable  " VIM only

    if v:version >= 703
        au FileType python set colorcolumn=80
    endif

    " python-mode stuff
    " Switch pylint, pyflakes, pep8, mccabe code-checkers
    " Can have multiply values "pep8,pyflakes,mcccabe"
    let g:pymode_lint_checker = "flake8"
    let g:pymode_rope_complete_on_dot = 0
    let g:pymofe_rope = 0
augroup END

augroup html
    au!
    au BufNewFile, BufRead *.html
    au FileType html set softtabstop=2
    au FileType html set tabstop=2
    au FileType html set shiftwidth=2
    au FileType html set expandtab
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabstops
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set foldenable
" Make folding indent sensitive
" set foldmethod=indent
" Don't autofold anything (but I can still fold manually)
" set foldlevel=2
" don't open folds when you search into them
" set foldopen-=search
" don't open folds when you undo stuff
" set foldopen-=undo

" vim filetype settings {{{
"augroup filetype_vim
"    au!
"    au FileType vim setlocal foldmethod=marker
"augroup END
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSERT mode
imap jj <ESC>
" TERMINAL mode
" map <ESC> to exit terminal mode and navigate throug windows
" via Alt + [hjkl]
:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
"nnoremap tr :tabprevious<CR>
"nnoremap ty :tabnext<CR>
"nnoremap <C-L> :nohl<CR><C-L>
"nnoremap <leader>n :NERDTreeToggle<CR>
"nnoremap <leader>C :set background=light<CR>
"nnoremap <leader>c :set background=dark<CR>

" do not jump on wrapped lines
"nnoremap j gj
"nnoremap k gk

" don't show these filetypes in NERDTree
"set wildignore+=*/tmp/*,*.so,*.swp,*.pyc
"let NERDTreeIgnore = ['\.pyc$', '\.so$', '\.swp$']

" ctrl-p
"let g:ctrlp_clear_cache_on_exit = 0
