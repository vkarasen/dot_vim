#!/bin/bash

usage()
{
cat << EOF
This script first clears and then installs the vim environment from github:/vkarasen/dot_vim repository
It will link the correct folders and files, download Vundle.vim and run VundleInstall once to download all plugins

usage: $0 options

OPTIONS:
   -h      Show this message
   -p      Path of the main .vim installation, by default the home directory
   -v      Verbose
EOF
exit 1
}

VERBOSE=
INSTALLPATH=$HOME

while getopts "hvp:" OPTION 
do
   case $OPTION in
      h)
         usage
         ;;
      v)
         VERBOSE="-v"
         ;;
      p)
         INSTALLPATH=$(realpath $OPTARG)
         ;;
      ?)
         usage
         ;;
   esac
done

# Make sure everything is clean before installing
rm -rf $VERBOSE $INSTALLPATH/.vim
rm -f $VERBOSE $INSTALLPATH/.vimrc

# bootstrap vundle
git clone https://github.com/VundleVim/Vundle.vim.git $INSTALLPATH/.vim/bundle/Vundle.vim

ln -sf $VERBOSE $(pwd -P)/vimrc $INSTALLPATH/.vimrc

if [ "$INSTALLPATH" != "$HOME" ]
then
   ./setup.sh $VERBOSE -p $INSTALLPATH
fi

vim +BundleInstall +qall
