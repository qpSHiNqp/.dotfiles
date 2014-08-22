""""""""""""""""""""""
" colors & indicators
"scriptencoding utf-8
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
"augroup END
syntax on
set listchars=tab:>-,trail:~
set list
"highlight SpecialKey cterm=underline ctermbg=gray ctermfg=gray
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
" ruler, number
set number
"set ruler
set cursorline
" folding
"set foldmethod=syntax

" statusline
set laststatus=2
"set showcmd
if isdirectory(expand('~/.vim/bundle/vim-fugitive'))
    set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%{fugitive#statusline()}\ \ %l,%c%V%8P
endif
"set hid

colorscheme monokai

""""""
" tab
set showtabline=4
set shiftwidth=4
set tabstop=4
set softtabstop=2
set expandtab

" indent
set autoindent
set cindent
autocmd FileType txt set noautoindent
autocmd FileType txt set nocindent

set backspace=indent,eol,start
set showmatch
set wildmenu
if has('mouse')
    set mouse=a
endif

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $
nnoremap 1 0

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>


" カーソル前の文字削除
"inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
"inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
"inoremap <silent> <C-d>e <Esc>lc^
" カーソルから行末まで削除
"inoremap <silent> <C-d>0 <Esc>lc$
" カーソルから行頭までヤンク
"inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>0 <Esc>ly$<Insert>

" 引用符, 括弧の設定
""inoremap { {}<Left>
""inoremap [ []<Left>
""inoremap ( ()<Left>
""inoremap " ""<Left>
""inoremap ' ''<Left>
""inoremap <> <><Left>

"""""""""""
" shortcut
nmap t :tabnew 
nmap ,m :tabnext<CR>
nmap ,n :tabprevious<CR>

"""""""""
" vundle
if has("unix")
    let s:uname = system("uname")
    if s:uname =~ "Darwin"
        if isdirectory(expand('~/.vim/vundle.git'))
            source ~/.vim_includes/.vundle

            set clipboard+=unnamed,autoselect

            source ~/.vim_includes/.php
            source ~/.vim_includes/git
        endif
        set makeprg=php\ -l\ %
        set errorformat=%m\ in\ %f\ on\ line\ %l
    endif
endif

""""""
" 文字コード周り
set encoding=utf-8
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
