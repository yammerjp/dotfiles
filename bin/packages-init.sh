#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

if [ "$(uname)" = "Darwin" ];then
  ech "Install packages for macOS"
  bash "$DOTFILES_DIR/bin/packages-init-macos.sh" "$1"

elif [ "$(uname)" = "Linux" ];then
  ech "Install packages for Ubuntu"
  bash "$DOTFILES_DIR/bin/packages-init-ubuntu.sh" "$1"
fi

