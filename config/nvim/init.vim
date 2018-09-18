set nocompatible
filetype off

" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
"""""
" Syntax Checking and Highlighting
"""""
" consider installing js-beautify, autopep8
Plug 'Chiel92/vim-autoformat'

Plug 'vim-syntastic/syntastic'
Plug 'vim-python/python-syntax'

" Markdown
Plug 'godlygeek/tabular' " tabular needs be before markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'

" typescript
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
"
" javascript / react jsx
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'Nonius/cargo.vim'

"""""
" Jedi
"""""
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'  " NVIM
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" autocomplete-flow
Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" autoclose
" Plug 'Townk/vim-autoclose'

"""""
" Tools
"""""
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-dadbod'
Plug 'jmcantrell/vim-virtualenv'

"NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Terminal/REPL
Plug 'kassio/neoterm'

" Neomake
" Plug 'neomake/neomake'

"""""
" vim-orgmode
"""""
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
" Plug 'terryma/vim-multiple-cursors'

"""""
" Style
"""""
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'

call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use emmet in html,css,js, tsx files
let g:user_emmet_install_global = 0
autocmd FileType html,css,typescript,javascript EmmetInstall
" use prettier for auto formatting
autocmd FileType javascript set formatprg=prettier\ --stdin
" autocmd BufWritePre *.js :normal gggqG
" deoplete.nvim
let g:deoplete#enable_at_startup = 1
" enable neosnippet to support func argument completion with autocomplete-flow
let g:neosnippet#enable_completed_snippet = 1
" Neoterm
" let g:neoterm_position = 'vertical' " set the neoterm pos to vertical
let g:neoterm_size=10

" run Neomake asynchronously
" autocmd! BufWritePost, BufEnter * Neomake
" call neomake#configure#automake('nrw', 750)
" :lopen when neomake runs
" let g:neomake_open_list = 2
" https://github.com/neomake/neomake/wiki/Makers
" let g:neomake_python_enabled_makers = ['pylint']
" let g:neomake_javascript_enabled_makers = ['eslint']

" autoformat Rust on save
let g:rustfmt_autosave = 1

"""""
" Syntax Checkers and Gutter
"""""
" vim-signify
let g:signify_vcs_list =  ['git']
let g:signify_realtime = 1
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Error symbols 
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "∙∙"
let syntastic_style_warning_symbol = "∙∙"
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
if (has("termguicolors"))
  set termguicolors
endif

" enable italics for the colorschemes
let g:gruvbox_italic = 1
let g:onedark_terminal_italics = 1

let g:airline_theme='onedark'
" let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" highligh all from vim-python/python-syntax
let g:python_highlight_all = 1
hi link pythonNone Boolean
hi Statement cterm=italic gui=italic
hi Conditional cterm=italic gui=italic
hi Operator cterm=italic gui=italic
hi Identifier cterm=italic gui=italic
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

colorscheme onedark
set background=dark
syntax enable

" transparent background
hi Normal ctermbg=None guibg=None
hi NonText ctermbg=None guibg=None
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

" autoclose some chars
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O<Paste>
inoremap <C-SPACE> <ESC>la

" don't show these filetypes in NERDTree
"set wildignore+=*/tmp/*,*.so,*.swp,*.pyc
"let NERDTreeIgnore = ['\.pyc$', '\.so$', '\.swp$']

" ctrl-p
"let g:ctrlp_clear_cache_on_exit = 0
