" include base config
source ~/.vim_includes/.base


" shortcut
nmap t :tabnew 
nmap ,m :tabNext<CR>
nmap ,n :tabprevious<CR>
nmap ,c :!svn ci -m 
nmap ,r :!svn up<CR> 

" Includes
source ~/.vim_includes/.color
source ~/.vim_includes/.char

if has("unix")
    let s:uname = system("uname")
    if s:uname =~ "Darwin"
        if isdirectory(expand('~/.vim/vundle.git'))
            source ~/.vim_includes/.vundle

            source ~/.vim_includes/.php
            source ~/.vim_includes/git
        endif
        set makeprg=php\ -l\ %
        set errorformat=%m\ in\ %f\ on\ line\ %l
    endif
endif


