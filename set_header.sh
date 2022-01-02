#!/bin/bash
# ./set_header.sh

# Set variables

if [ -n "$ZSH_VERSION" ]
then
    RCFILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]
then
    RCFILE="$HOME/.bashrc"
else
    echo -n "No compatible shell detected, aborting..."
    exit
fi

if [ ! -f $RCFILE ]
then
    touch $RCFILE
fi

if [ ! -f "$USER/.vimrc" ]
then
    touch "$HOME/.vimrc"
fi

if [ ! $1 ]
then
    echo -n "Please enter your 42 username: "
    read USER
    echo -n "User is $USER"
else
    USER="$1"
    echo -n "User is $USER" 
fi

if [ -z "$USER" ]
then
    echo "USER=`/usr/bin/whoami`" >> $RCFILE
    echo "export USER" >> $RCFILE
else
    echo "USER="$USER"" >> $RCFILE
    echo "export USER" >> $RCFILE
    echo "let g:user42 = '"$USER"'" >> "$HOME/.vimrc"
fi

if [ -z "$MAIL" ]
then
    echo "MAIL="$USER@student.42adel.org.au"" >> $RCFILE
    echo "export MAIL" >> $RCFILE
    echo "let g:mail42 = '"$USER@student.42adel.org.au"'" >> "$HOME/.vimrc"
fi

mkdir -p ~/.vim/plugin

# Add stdheader to vim plugins
cp plugin/stdheader.vim ~/.vim/plugin/

source $RCFILE
