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
  call dein#add('Shougo/vimproc.vim')
  call dein#add('Shougo/vimshell.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('haya14busa/incsearch.vim')
  call dein#add('thinca/vim-ref')
  call dein#add('vim-scripts/sudo.vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

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
set incsearch
set hlsearch
set ignorecase
set smartcase
