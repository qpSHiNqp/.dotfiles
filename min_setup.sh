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
echo "deploying .zshrc..."
if [ -f '.zshrc' ]; then
	rm .zshrc
fi

source ~/.zshrc

ln -s ~/.dotfiles/.zshrc
echo "done."
