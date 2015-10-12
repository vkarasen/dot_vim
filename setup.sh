#!/bin/bash

usage()
{
cat << EOF
This script links the .vim and .vimrc files/dirs from a remote location to your home

usage: $0 options

OPTIONS:
   -h       Show this message
   -p       remote path
   -v       Verbose
EOF
exit 1
}

VERBOSE=
SOURCEPATH=

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
         SOURCEPATH=$(realpath $OPTARG)
         ;;
      ?)
         usage
         ;;
   esac
done

if [[ -z $SOURCEPATH ]]
then
   usage
fi

ln -sf $VERBOSE $SOURCEPATH/.vimrc $HOME/.vimrc

ln -sf $VERBOSE $SOURCEPATH/.vim $HOME/.vim
