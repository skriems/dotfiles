set nocompatible
filetype off

" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" UI
Plug 'mhinz/vim-signify'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Syntax and Highlighting
Plug 'sheerun/vim-polyglot'
" Plug 'evanleck/vim-svelte'
Plug 'godlygeek/tabular' " tabular needs be before markdown
Plug 'plasticboy/vim-markdown'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'rhysd/vim-wasm'

" Fuzzy Finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim', { 'do': './install --bin' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'

" Debugger
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug '~/repos/vim-vebugger'
" Plug 'idanarye/vim-vebugger', { 'branch': 'develop' }
" Plug 'vim-vdebug/vdebug'

" Misc
Plug 'iamcco/markdown-preview.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
"Plug 'jmcantrell/vim-virtualenv'
Plug 'neomake/neomake'
" Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-commentary'

" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'danilo-augusto/vim-afterglow'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'ajmwagar/vim-deus'

call plug#end()
" }}}

" General {{{

let mapleader = ','
" let maplocalleader = '_'
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

filetype plugin on
" use project local .exrc files (i.e for setting project local table helpers
" for vim-dadbod-ui)
set exrc
" encoding
set encoding=utf-8
" mouse scrolling in iTerm2
set mouse=nicr
" attempt to improve speed in iTerm2
" set regexpengine=1
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
" 80 cols wide
set columns=80
" Keep 5 lines (top/bottom) for scope
set so=5
" do blink
set visualbell
" no noises
set noerrorbells
" show whitelist
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

"""""""""" Tabstops
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

"""""""""" Indentation
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
set numberwidth=3
" expand <CR>
let delimitMate_expand_cr = 1

"""""""""" Folding
set foldenable
" fold based on syntax files
set foldmethod=syntax
" Don't autofold anything (but I can still fold manually)
" set foldlevel=2
" don't open folds when you search into them
" set foldopen-=search
" don't open folds when you undo stuff
" set foldopen-=undo

augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" }}}

" ColorScheme {{{
if (has("termguicolors"))
    " not sure if the below two are needed (in neovim)
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
endif

set background=dark

function! MyHighlights() abort
    hi link pythonNone Boolean
    hi Statement cterm=italic gui=italic
    hi Conditional cterm=italic gui=italic
    hi Operator cterm=italic gui=italic
    hi Identifier cterm=italic gui=italic
    " transparency
    hi Normal ctermbg=None guibg=None
    hi NonText ctermbg=None guifg=#3c3836 guibg=None
    hi SignColumn ctermbg=None guibg=None
    hi CursorLineNr ctermbg=None guibg=None
    hi GruvboxRedSign ctermbg=None guibg=None " SignifySignDelete
    hi GruvboxGreenSign ctermbg=None guibg=None "SignifySignAdd
    hi GruvboxYellowSign ctermbg=None guibg=None
    hi GruvboxBlueSign ctermbg=None guibg=None
    hi GruvboxPurpleSign ctermbg=None guibg=None
    hi GruvboxAquaSign ctermbg=None guibg=None "SignifySignChange
    hi GruvboxOrangeSign ctermbg=None guibg=None
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

let g:afterglow_italic_comments = 1
let g:deepspace_italics = 1
let g:gruvbox_italic = 1
let g:onedark_terminal_italics = 1

" highligh all from vim-python/python-syntax
let g:python_highlight_all = 1

" improve default java highlighting
let java_highlight_functions = 1
let java_highlight_all = 1

if !exists("g:syntax_on")
    syntax enable
endif

colorscheme gruvbox
" }}}

" Plugin Config {{{

" Conquer of Completion {{{
let g:coc_global_extensions = [
    \ 'coc-angular',
    \ 'coc-css',
    \ 'coc-diagnostic',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-flow',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-java',
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-phpls',
    \ 'coc-prettier',
    \ 'coc-python',
    \ 'coc-rust-analyzer',
    \ 'coc-snippets',
    \ 'coc-stylelint',
    \ 'coc-svg',
    \ 'coc-tslint-plugin',
    \ 'coc-tsserver',
    \ 'coc-yaml', ]

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,typescript.tsx,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

nnoremap <silent> <leader>sw <Plug>GenerateDiagram
" }}}

" grep and fzf {{{
if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg --vimgrep %s'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Augmenting Rg command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" :Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" bind F to grep word under cursor
nnoremap F :Rg! <C-R><C-W><CR>
" open :Files with fzf
nnoremap <silent> <leader>O :Files<CR>
" }}}

" Lightline {{{

" mode is shown in the statusline
set noshowmode

" always show the status line
set laststatus=2
" set statusline+=%{coc#status()}
" set statusline+=%{fugitive#statusline()}
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" set statusline+=%#warningmsg#
" set statusline+=%*

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left':[ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'fugitive' ], [ 'filetype', 'fileencoding', 'fileformat', 'percent', 'cocstatus' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \   'fileformat': 'LightLineFileformat',
    \   'filetype': 'LightLineFiletype',
    \   'fileencoding': 'LightLineFileencoding',
    \   'mode': 'LightLineMode'
    \ },
    \ 'subseparator': { 'left': '|', 'right': '|' },
        \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ' '  " edit here for cool mark
      let _ = fugitive#head()
      return winwidth(0) > 70 ? strlen(_) ? mark._ : '': ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  if exists('*WebDevIconsGetFileTypeSymbol')
    let l:filetype = WebDevIconsGetFileTypeSymbol() . ' ' . &filetype
  else
    let l:filetype = &filetype
  endif
  return winwidth(0) > 70 ? (strlen(l:filetype) ? l:filetype : 'no ft') : ''
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" Others {{{

let g:user_emmet_install_global = 0
augroup emmet
    au!
    au FileType html,css,javascript,typescript,typescript.tsx EmmetInstall
augroup END

" vim-dadbod-ui
let g:db_ui_dotenv_variable_prefix = 'DBUI_'
let g:db_ui_save_location = '~/.config/nvim/dbui'

" vebugger
let g:vebugger_view_source_cmd='edit'

" vim-polyglot disable syntax for specific filetypes
"let g:polyglot_disabled = ['css']

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:markdown_fenced_languages = ['css', 'js=javascript', 'jsx=javascriptreact', 'ts=typescript', 'tsx=typescript.tsx', 'rs=rust']

" neomake
let g:neomake_rust_cargo_command = ['cargo-clippy']
" nmap <Leader><Space>o :lopen<CR>      " open location window
" nmap <Leader><Space>c :lclose<CR>     " close location window
" nmap <Leader><Space>, :ll<CR>         " go to current error/warning
" nmap <Leader><Space>n :lnext<CR>      " next error/warning
" nmap <Leader><Space>p :lprev<CR>      " previous error/warning

" NERD 
let g:NERDTreeWinSize=40
let NERDTreeIgnore = ['\.pyc$', '\.so$', '\.swp$', '\.DS_Store']
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc

" vim-signify
let g:signify_vcs_list =  ['git']
let g:signify_realtime = 1
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

" vim-devicons: avoid unnecessary system() calls; most likely only necessary
" on OSX
let g:WebDevIconsOS = 'Darwin'
" }}}
" }}}

" FileTypes {{{
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
    au FileType javascript,javascriptreact,typescript,typescriptreact set softtabstop=2
    au FileType javascript,javascriptreact,typescript,typescriptreact set tabstop=2
    au FileType javascript,javascriptreact,typescript,typescriptreact set shiftwidth=2
    au FileType javascript,javascriptreact,typescript,typescriptreact set expandtab
augroup END

augroup markdown
    au!
    au BufNewFile, BufRead *.md,*.mdx
    au FileType markdown,markdown.mdx set textwidth=79
augroup end
" }}}

" Keybindings {{{
" exit INSERT mode
:inoremap jk <ESC>
" i.e. 'dp' -> delete inside parentheses
:onoremap p i(

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap tr :tabprevious<CR>
nnoremap tz :tabnext<CR>

" navigation
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" do not jump on wrapped lines
"nnoremap j gj
"nnoremap k gk

" navigation in TERMINAL mode
" map <ESC> to exit terminal mode and navigate throug windows
" via Alt + [hjkl]
" :tnoremap <Esc> <C-\><C-n>
" :tnoremap <A-h> <C-\><C-n><C-w>h
" :tnoremap <A-j> <C-\><C-n><C-w>j
" :tnoremap <A-k> <C-\><C-n><C-w>k
" :tnoremap <A-l> <C-\><C-n><C-w>l

map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
