"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.vim/')
  call dein#begin('$HOME/.vim/')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  "call dein#add('osyo-manga/shabadou.vim')
  "call dein#add('osyo-manga/vim-watchdogs')
  "call dein#add('KazuakiM/vim-qfstatusline')
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/nerdtree')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('thinca/vim-ref')
  call dein#add('itchyny/lightline.vim')
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('leafgarland/typescript-vim')
  "call dein#add('othree/yajs.vim', {'merged':0})

  " You can specify revision/branch/tag.
  "call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
"
"Basic
set encoding=utf-8

"Colors 
colorscheme monokai
set clipboard+=unnamed,autoselect
set laststatus=2
set showtabline=2
set cursorline
set number
highlight SpecialKey ctermbg=none
highlight OverLength cterm=underline ctermbg=none ctermfg=red guibg=#592929
match Overlength /\%81v.\+/
set listchars=tab:>-,trail:~
set list
set ruler

set backspace=indent,eol,start
set showmatch

set wildmenu

"Indents / Tabs
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set cindent
autocmd FileType txt set noautoindent
autocmd FileType txt set nocindent
set modeline

"Remaps
nnoremap + <C-a>
nnoremap - <C-x>
"Cursor moves in edit mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>

"Controls
if has('mouse')
  set mouse=a
endif

" shortcut
nmap t :tabnew 
nmap ,m :tabnext<CR>
nmap ,n :tabprevious<CR>

cmap w!! w !sudo tee > /dev/null %

"Search
highlight Search term=reverse ctermfg=235 ctermbg=186 guifg=#272822 guibg=#e6db74
set incsearch
set hlsearch
set ignorecase
set smartcase

"neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><C-i>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><TAB> neocomplete#smart_close_popup()."\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename':  'LightlineFilename'
      \ },
      \ }

function! LightlineFilename()
  let filename = expand('%') !=# '' ? expand('%') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

let g:vimshell_force_overwrite_statusline = 0
