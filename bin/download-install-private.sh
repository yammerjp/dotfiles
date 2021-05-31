#!/bin/bash -e

DOTDIR="$HOME/src/github.com/yammerjp/dotfiles-private"
git clone https://github.com/yammerjp/dotfiles-private.git $DOTDIR
cd $DOTDIR

mkdir -p bin
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/bin/link.sh > ./bin/link.sh
bash bin/link.sh

# ssh directory permission settings
