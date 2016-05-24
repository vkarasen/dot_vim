#!/bin/bash

usage()
{
cat << EOF
This script first clears and then installs the vim environment from the github:/vkarasen/dot_vim repository
It will link the correct folders and files, download Vundle.vim and run VundleInstall once to download all plugins

usage: $0 options

OPTIONS:
   -h      Show this message
   -p      Path of the main .vim installation, by default the home directory
   -v      Verbose mode
EOF
exit 1
}


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

INSTALLPATH=${INSTALLPATH:-$HOME}

# Make sure everything is clean before installing
rm -rf $VERBOSE $INSTALLPATH/.vim*

# bootstrap vundle
git clone https://github.com/VundleVim/Vundle.vim.git $INSTALLPATH/.vim/bundle/Vundle.vim

ln -sf $VERBOSE $(pwd -P)/vimrc $INSTALLPATH/.vimrc

if [ "$INSTALLPATH" != "$HOME" ]
then
   ./setup.sh $VERBOSE -p $INSTALLPATH
fi

vim +BundleInstall +qall
