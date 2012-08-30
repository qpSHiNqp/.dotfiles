#!/bin/sh

cd ~
if [ ! -d '.dotfiles' ]; then
	echo "cloning..."
	git clone https://github.com/qpSHiNqp/.dotfiles.git
fi

cd ~/.dotfiles
echo "pulling latest conffiles..."
git pull

cd ~
echo "deploying .zshrc ..."
if [ -f '.zshrc' ]; then
	rm .zshrc
fi
ln -s ~/.dotfiles/.zshrc

cd ~
echo "deploying .zsh_includes/ ..."
if [ -f '.zsh_includes' ]; then
	rm .zsh_includes
fi
ln -s ~/.dotfiles/.zsh_includes

source ~/.zshrc

echo "done."