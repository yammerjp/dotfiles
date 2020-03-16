#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

cd ..

DOTFILES_DIR=`pwd`

# symbolic link
# ln -s .bashrc ~/.bashrc
# ln -s .vimrc ~/.vimrc

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo "link $DOTFILES_DIR/$f -> $HOME/$f"
    ln -s "$DOTFILES_DIR/$f" "$HOME/$f"
done
