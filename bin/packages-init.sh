#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

echo "Build and Install packages"
bash "$DOTFILES_DIR/bin/packages-init/common.sh" "$1"

if [ "$(uname)" = "Darwin" ];then
  echo "Install packages for macOS"
  bash "$DOTFILES_DIR/bin/packages-init/macos.sh" "$1"

elif [ "$(uname)" = "Linux" ];then
  echo "Install packages for Ubuntu"
  bash "$DOTFILES_DIR/bin/packages-init/ubuntu.sh" "$1"
fi

