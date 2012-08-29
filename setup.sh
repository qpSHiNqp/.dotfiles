#!/bin/sh

dir=`dirname $0`
echo "script path: ${dir}/`basename $0`"
cd $dir
echo "pulling latest conffiles..."
git pull

echo "remove file ? [y/n]"
read ANS
 
if [ $ANS != 'y' -a $ANS != 'yes' -a $ANS != '' ]; then
	exit 0
fi

cd ~
echo "deploying .zshrc ..."
rm ~/.zshrc
ln -s ${dir}/.zshrc

echo "deploying .zsh_includes/ ..."
rm -rf ~/.zsh_includes
ln -s ${dir}/.zsh_includes

echo "deploying .vimrc ..."
rm ~/.vimrc
ln -s ${dir}/.vimrc

echo "deploying .vim_includes/ ..."
rm -rf ~/.vim_includes
ln -s ${dir}/.vim_includes

echo "deploying .vim/ ..."
rm -rf ~/.vim
ln -s ${dir}/.vim

echo "done."
