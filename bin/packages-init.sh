#!/bin/bash -e

DOTFILES_BIN_DIR=$(cd "$(dirname "$0")"; pwd)

echo "Build and Install packages"
bash "$DOTFILES_BIN_DIR/packages-init/common.sh" "$1"

if [ "$(uname)" = "Darwin" ];then
  echo "Install packages for macOS"
  bash "$DOTFILES_BIN_DIR/packages-init/macos.sh" "$1"

elif [ "$(uname)" = "Linux" ];then
  echo "Install packages for Ubuntu"
  bash "$DOTFILES_BIN_DIR/packages-init/ubuntu.sh" "$1"
fi

