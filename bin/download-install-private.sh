#!/bin/bash -e

DOTDIR="$HOME/src/github.com/yammerjp/dotfiles-private"
git clone https://github.com/yammerjp/dotfiles-private.git $DOTDIR
cd $DOTDIR

bash bin/link.sh
# ssh directory permission settings
