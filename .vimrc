"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:vim_dir = expand("$HOME/.vim")
let s:dein_repo_dir = s:vim_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein/vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Required:
if dein#load_state(s:vim_dir)
  call dein#begin(s:vim_dir)

  call dein#load_toml(s:vim_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:vim_dir . '/dein_lazy.toml', {'lazy': 1})

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
" Open QuickFix cwindow after vimgrep
autocmd QuickFixCmdPost *grep* cwindow

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
"inoremap <expr><C-i>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> pumvisible() ? "\<C-y>\<BS>" : "\<BS>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"

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
