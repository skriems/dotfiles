set nocompatible
filetype off

" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" consider installing js-beautify, autopep8
Plug 'Chiel92/vim-autoformat'
" vim-orgmode
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
" Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
" syntax and style
Plug 'mhartington/oceanic-next'
Plug 'vim-python/python-syntax'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'  " show git branch
" tabular needs be before markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" typescript
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
" javascript / react jsx
" Plug 'pangloss/vim-javascript'
" Plug 'maxmellon/vim-jsx-pretty'
" Emmet
Plug 'mattn/emmet-vim'
" virtualenv
" Plug 'jmcantrell/vim-virtualenv'
"NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Terminal/REPL
Plug 'kassio/neoterm'
" Jedi
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'  " NVIM
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" autocomplete-flow
Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Neomake
Plug 'neomake/neomake'

call plug#end()

syntax on  " enables standard syntax
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use emmet in html,css,js files
let g:user_emmet_install_global = 0
autocmd FileType html,css,typescript,javascript EmmetInstall
" use prettier for auto formatting
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd BufWritePre *.js :normal gggqG
" deoplete.nvim
let g:deoplete#enable_at_startup = 1
" enable neosnippet to support func argument completion with autocomplete-flow
let g:neosnippet#enable_completed_snippet = 1
" Neoterm
" let g:neoterm_position = 'vertical' " set the neoterm pos to vertical
let g:neoterm_size=10

" run Neomake asynchronously
autocmd! BufWritePost, BufEnter * Neomake
call neomake#configure#automake('nrw', 750)
" :lopen when neomake runs
" let g:neomake_open_list = 2
" https://github.com/neomake/neomake/wiki/Makers
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_javascript_enabled_makers = ['eslint']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" How many lines of history to remember
set history=1000
" enable error files and error jumping
set cf
" support all three, in this order
set ffs=unix,mac,dos
" make sure it can save viminfo
set viminfo+=!
" none of these should be word dividers, so make them not be
set isk+=_,$,@,%,#,-
" show wrapped lines:
set sbr=>
" Allow backspace in insert mode
set backspace=indent,eol,start
" realod on external writes
set autoread

"""""""""""""""""""""""""""""""""
" Style
"""""""""""""""""""""""""""""""""
" Syntax
syntax enable  " enables specific syntax
if (has("termguicolors"))
  set termguicolors
endif
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tagbar#enabled = 0
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
" show matching brackets on search
set showmatch
" how many tenths of a second to blink matching brackets for
set mat=5
" do not highlight search for phrases
set nohlsearch
" BUT do highlight as you type your search phrase
set incsearch
set columns=80 " 80 cols wide
" Keep 5 lines (top/bottom) for scope
set so=5
" do blink
set visualbell
" no noises
set noerrorbells
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
" Tabstops
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent
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
" FileTypes
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
    au FileType python set number
    au FileType python set relativenumber
    au FileType python nnoremap <buffer> <localleader>c I#<esc>
    au FileType python set colorcolumn=80
augroup END

augroup html
    au!
    au BufNewFile, BufRead *.html
    au FileType html set softtabstop=2
    au FileType html set tabstop=2
    au FileType html set shiftwidth=2
    au FileType html set expandtab
augroup END

augroup js
    au!
    au BufNewFile, BufRead *.js
    au FileType javascript set softtabstop=2
    au FileType javascript set tabstop=2
    au FileType javascript set shiftwidth=2
    au FileType javascript set expandtab
augroup END

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
"
" neomake
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

" do not jump on wrapped lines
"nnoremap j gj
"nnoremap k gk

" don't show these filetypes in NERDTree
"set wildignore+=*/tmp/*,*.so,*.swp,*.pyc
"let NERDTreeIgnore = ['\.pyc$', '\.so$', '\.swp$']

" ctrl-p
"let g:ctrlp_clear_cache_on_exit = 0
