#!/bin/bash -e

# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

# os initializing setup
#  ... ubuntu chsh
which zsh ||  (echo "Please install zsh" && exit 1)
chsh -s $(shell which zsh)

#  ... ubuntu home dir
# mv "~/ダウンロード" "~/Downloads"
#                                   ... and so on ...
LANG=C xdg-user-dirs-gtk-update

# package install
bash ./install-packages.sh

# vim init
vim -s ./vimop

# npm init
npm install --global
