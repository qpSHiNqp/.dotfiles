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

cd ~
echo "deploying .zshrc ..."
if [ -f '.zshrc' ]; then
	rm .zshrc
fi
ln -s ~/.dotfiles/.zshrc
source ~/.zshrc

echo "deploying .zsh_includes/ ..."
if [ -d '.zsh_includes' ]; then
	rm .zsh_includes
fi
ln -s ~/.dotfiles/.zsh_includes

echo "deploying .vimrc ..."
if [ -f '.vimrc' ]; then
	rm .vimrc
fi
ln -s ~/.dotfiles/.vimrc

echo "deploying .vim_includes/ ..."
if [ -d '.vim_includes' ]; then
	rm .vim_includes
fi
ln -s ~/.dotfiles/.vim_includes

echo "deploying .vim/ ..."
if [ -d '.vim' ]; then
	rm .vim
fi
ln -s ~/.dotfiles/.vim

echo "done."
