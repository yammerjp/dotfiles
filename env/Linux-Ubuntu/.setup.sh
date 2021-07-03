#!/bin/bash -e

# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

read -sp password

# Change login shell to zsh.
if ! which zsh; then
  echo "Please install zsh"
  exit 1
fi
username=`whoami`
echo "$password" | sudo -S chsh --shell `which zsh` "$username"

#  ... ubuntu home dir
# mv "~/ダウンロード" "~/Downloads"
#                                   ... and so on ...
LANG=C xdg-user-dirs-gtk-update

# package install
echo "$password" | sudo -S bash ./.setup-packages.sh

# vim init
vim -s ./vimop

# npm init
yarn global add
