if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/shintaro/.vim/repos/github.com/Shougo/dein.vim/,/Users/shintaro/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,/Users/shintaro/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/shintaro/.vimrc', '/Users/shintaro/.vim/dein.toml', '/Users/shintaro/.vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/shintaro/.vim'
let g:dein#_runtime_path = '/Users/shintaro/.vim/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/shintaro/.vim/.cache/.vimrc'
let &runtimepath = '/Users/shintaro/.vim/repos/github.com/Shougo/dein.vim/,/Users/shintaro/.vim,/usr/local/share/vim/vimfiles,/Users/shintaro/.vim/repos/github.com/Shougo/dein.vim,/Users/shintaro/.vim/.cache/.vimrc/.dein,/usr/local/share/vim/vim80,/Users/shintaro/.vim/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/shintaro/.vim/after'
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['neocomplete.vim'])
