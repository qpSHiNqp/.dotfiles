#! /bin/zsh

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

source ~/.zshrc

echo "Deployed. You must type \"source ~/.zshrc\" to apply settings you downloaded."
echo "done."
