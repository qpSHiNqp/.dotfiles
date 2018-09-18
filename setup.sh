#! /bin/zsh

cd ~
if [ ! -d '.dotfiles' ]; then
	echo "cloning..."
	git clone https://github.com/qpSHiNqp/.dotfiles.git
fi

cd ~/.dotfiles
echo "pulling latest conffiles..."
git pull

echo "We may overwrite config files you editted. continue? [y/n]"
read ANS
 
if [ $ANS != 'y' -a $ANS != 'yes' -a $ANS != '' ]; then
	echo "exitting..."
	exit 0
fi

unalias rm
cd ~
if [ ! -d "$HOME/.zsh_includes" ]; then
  mkdir -p "$HOME/.zsh_includes"
fi
echo "deploying .zshrc ..."
if [ -f '.zshrc' ]; then
	rm .zshrc
fi
ln -s ~/.dotfiles/.zshrc
source ~/.zshrc

echo "deploying .vimrc ..."
if [ -f '.vimrc' ]; then
	rm .vimrc
fi
ln -s ~/.dotfiles/.vimrc

echo "deploying .vim_includes/ ..."
if [ -d '.vim_includes' ]; then
	rm -rf .vim_includes
fi
ln -s ~/.dotfiles/.vim_includes

echo "deploying .vim/ ..."
if [ -d '.vim' ]; then
	rm -rf .vim
fi
ln -s ~/.dotfiles/.vim

echo "deploying .screenrc ..."
if [ -f '.screenrc' ]; then
	rm .screenrc
fi
ln -s ~/.dotfiles/.screenrc

echo "deploying .screen_includes/ ..."
if [ -d '.screen_includes' ]; then
	rm -rf .screen_includes
fi
ln -s ~/.dotfiles/.screen_includes

echo "Deployed. You must type \"source ~/.zshrc\" to apply settings you downloaded."
echo "done."
