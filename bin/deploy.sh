#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

alias ech="$SCRIPT_DIR/echo.sh"

cd ..

DOTFILES_DIR=`pwd`

# symbolic link
# ln -s .bashrc ~/.bashrc
# ln -s .vimrc ~/.vimrc

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ech "link $DOTFILES_DIR/$f -> $HOME/$f"
    ln -s "$DOTFILES_DIR/$f" "$HOME/$f"
done

