" include base config
source ~/.vim_includes/.base

" shortcut
nmap t :tabnew 
nmap ,n :tabNext<CR>
nmap ,m :tabprevious<CR>
nmap ,c :!svn ci -m 
nmap ,r :!svn up<CR> 

" Includes
source ~/.vim_includes/.color
source ~/.vim_includes/.char
source ~/.vim_includes/.vundle
