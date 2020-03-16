#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

cd ..

# symbolic link
# ln -s .bashrc ~/.bashrc
# ln -s .vimrc ~/.vimrc

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo link "$f"
    ln -s "$f" ~/"$f"
done
