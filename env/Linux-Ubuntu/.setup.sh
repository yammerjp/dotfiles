#!/bin/bash -e

# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

read -rsp password

# Change login shell to zsh.
if ! command -v zsh; then
  echo "Please install zsh"
  exit 1
fi
username="$(whoami)"
echo "$password" | sudo -S chsh --shell "$(command -v zsh)" "$username"

#  ... ubuntu home dir
# mv "~/ダウンロード" "~/Downloads"
#                                   ... and so on ...
if [ "$CI" != "true" ]; then
  LANG=C xdg-user-dirs-gtk-update
fi

# package install
echo "$password" | sudo -S bash ./.setup-packages.sh

# vim init
vim -s ./vimop

# npm init
yarn global add
