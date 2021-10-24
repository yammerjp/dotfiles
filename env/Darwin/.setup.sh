#!/bin/bash -e

# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

# os initializing setup
bash .userdefaults-init.sh

# package install
brew bundle --file ~/.Brewfile

# setup anyenv
anyenv install nodenv
anyenv install phpenv
anyenv install rbenv

# vim init
vim -s .vimop

echo "Nothing to do" 1>&2
