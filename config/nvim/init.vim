set nocompatible
filetype off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

"""""
" Syntax Checking and Highlighting
"""""
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'vim-syntastic/syntastic'

" Python
Plug 'vim-python/python-syntax'

" Markdown
Plug 'godlygeek/tabular' " tabular needs be before markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

" javascript / react jsx
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
"Plug 'maxmellon/vim-jsx-improve'

" Rust & Cargo
Plug 'rust-lang/rust.vim'
Plug 'Nonius/cargo.vim'
Plug 'rhysd/vim-wasm'

" Java
Plug 'artur-shaik/vim-javacomplete2'

" Dart
"Plug 'dart-lang/dart-vim-plugin'

" C
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" Docker"
Plug 'ekalinin/Dockerfile.vim'

" PHP
Plug 'StanAngeloff/php.vim', {'for': 'php'}
" vim-vdebug
Plug 'vim-vdebug/vdebug'

"""""
" Conquer of Completion
"""""
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" coc-css
" coc-emmet
" coc-highlight
" coc-html
" coc-java
" coc-json
" coc-python
" coc-rls
" coc-snippets
" coc-tsserver
" coc-tslint-plugin
" coc-yaml
"""""

"""""
" Tools
"""""
" Fuzzy Finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-dadbod'
"Plug 'jmcantrell/vim-virtualenv'

"NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
"
" Terminal/REPL
" Plug 'kassio/neoterm'

" Neomake
Plug 'neomake/neomake'

"""""
" vim-orgmode
"""""
" Plug 'jceb/vim-orgmode'
" Plug 'tpope/vim-speeddating'
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
" General Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mouse scrolling in iTerm2
set mouse=nicr
" attempt to improve speed in iTerm2
" set regexpengine=1
" encoding
set encoding=utf-8
" How many lines of history to remember
set history=1000
" Save undo history
set undofile
set undodir=~/.vim/undodir
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
" Style
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""
" Status line:
""""""""
" always show the status line
set laststatus=2
" show branch via fugitive
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
""""
" CoC
""""
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
" [CoC] if you want to disable auto detect, comment out those two lines
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = ['branch', 'hunks', 'coc']

""""""""
" Colorscheme etc
""""""""
if (has("termguicolors"))
    set termguicolors
endif

function! MyHighlights() abort
    highlight link pythonNone Boolean
    highlight Statement cterm=italic gui=italic
    highlight Conditional cterm=italic gui=italic
    highlight Operator cterm=italic gui=italic
    highlight Identifier cterm=italic gui=italic
    highlight Normal ctermbg=None guibg=None
    highlight NonText ctermbg=None guibg=None
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" colorscheme
" colorscheme OceanicNext
" colorscheme onedark
colorscheme gruvbox
set background=dark

" enable italics for the colorschemes
"let g:gruvbox_italicize_strings = 1
let g:gruvbox_italic = 1
let g:onedark_terminal_italics = 1

"let g:airline_theme='onedark'
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" highligh all from vim-python/python-syntax
let g:python_highlight_all = 1

if !exists("g:syntax_on")
    syntax enable
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable folding for vim-markdown
let g:vim_markdown_folding_disabled = 1

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,typescript,typescript.tsx EmmetInstall

"""""""""
" CoC
"""""""""
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,typescript.tsx,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add diagnostic info for https://github.com/itchyny/lightline.vim
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
"      \ },
"      \ 'component_function': {
"      \   'cocstatus': 'coc#status'
"      \ },
"      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" enable neosnippet to support func argument completion with autocomplete-flow
"let g:neosnippet#enable_completed_snippet = 1

" Neoterm
" let g:neoterm_position = 'vertical' " set the neoterm pos to vertical
" let g:neoterm_size=10

"""""
" Gutter
"""""
" vim-signify
let g:signify_vcs_list =  ['git']
let g:signify_realtime = 1
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

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

""""""""
" Java
" https://github.com/artur-shaik/vim-javacomplete2
""""""""
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" To enable smart (trying to guess import option) inserting class imports with F4, add:
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
" To enable usual (will ask for import option) inserting class imports with F5, add:
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
" To add all missing imports with F6:
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)

" To remove all unused imports with F7:
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

""""""
"" default mapping
""""""
" nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
" nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
" nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
" nmap <leader>jii <Plug>(JavaComplete-Imports-Add)
"
" imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
" imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
" imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
" imap <C-j>ii <Plug>(JavaComplete-Imports-Add)
"
" nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
"
" imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)
"
" nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
" nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
" nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
" nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
" nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
" nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
" nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
" nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
"
" imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
" imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
" imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
"
" vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
" vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
" vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
"
" nmap <silent> <buffer> <leader>jn <Plug>(JavaComplete-Generate-NewClass)
" nmap <silent> <buffer> <leader>jN <Plug>(JavaComplete-Generate-ClassInFile)

" disable the default mapping
" "let g:JavaComplete_EnableDefaultMappings = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabstops
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileTypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" global interpreters for nvim so that we don't need to
" 'pip install neovim' in every virtualenv
let g:python3_host_prog = "$HOME/.virtualenvs/nvim3/bin/python"
let g:python_host_prog = "$HOME/.virtualenvs/nvim2/bin/python"

augroup python
    au!
    au BufNewFile /**/*.py 0r ~/.vim/skeleton/python.py|norm G
    au FileType python set omnifunc=pythoncomplete#Complete
    au FileType python set number
    au FileType python set relativenumber
    au FileType python nnoremap <buffer> <localleader>c I#<esc>
    au FileType python set textwidth=79
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
    au BufNewFile, BufRead *.js,*.jsx,*.ts,*.tsx
    au FileType javascript,typescript,typescript.tsx set softtabstop=2
    au FileType javascript,typescript,typescript.tsx set tabstop=2
    au FileType javascript,typescript,typescript.tsx set shiftwidth=2
    au FileType javascript,typescript,typescript.tsx set expandtab
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autoindent
set ai
" smartindent
set si
" do c-style indenting
" set cindent
" show line numbers
set number
" show relative line number
set relativenumber
" width of 'gutter'
set numberwidth=2
" expand <CR>
let delimitMate_expand_cr = 1

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
" grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg --vimgrep %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap F :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

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
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l
nnoremap tr :tabprevious<CR>
nnoremap tz :tabnext<CR>
"nnoremap <C-L> :nohl<CR><C-L>
nnoremap <leader>n :NERDTreeToggle<CR>
"
" neomake
let g:neomake_rust_cargo_command = ['cargo-clippy']
" nmap <Leader><Space>o :lopen<CR>      " open location window
" nmap <Leader><Space>c :lclose<CR>     " close location window
" nmap <Leader><Space>, :ll<CR>         " go to current error/warning
" nmap <Leader><Space>n :lnext<CR>      " next error/warning
" nmap <Leader><Space>p :lprev<CR>      " previous error/warning

" do not jump on wrapped lines
"nnoremap j gj
"nnoremap k gk

" autoclose some chars
inoremap " ""<left>
"inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O<Paste>
inoremap <C-SPACE> <ESC>la

" don't show these filetypes in NERDTree
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc
let NERDTreeIgnore = ['\.pyc$', '\.so$', '\.swp$']

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" ctrl-p
"let g:ctrlp_clear_cache_on_exit = 0
