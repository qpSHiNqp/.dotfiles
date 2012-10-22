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
		source ~/.vim_includes/.vundle
	endif
endif
