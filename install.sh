#!/bin/bash

# Make sure everything is clean before installing
rm -rf $HOME/.vim 
rm $HOME/.vimrc


# Quick install script to setup all symlinks
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

CURRENT_FOLDER=$(pwd -P)

#symlink $SRCFLD/vimrc $HOME/.vimrc
ln -s -f -v $CURRENT_FOLDER/vimrc $HOME/.vimrc

vim +BundleInstall +qall
