#!/bin/sh

dir=`dirname $0`
echo "script path: ${dir}/`basename $0`"
cd $dir
echo "pulling latest conffiles..."
git pull
echo "deploying .zshrc..."
cd ~
rm ~/.zshrc
ln -s ${dir}/.zshrc
echo "done."
