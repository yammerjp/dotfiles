#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
cd $DOTFILES_DIR

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }


if [ $(uname) = "Darwin" ];then
  ech "Install packages for macOS"
  which brew && :
  if [ "$?" != "0" ];then
    ech "Need homebrew. Prease install homebrew and retry the script."
    exit 1
  fi
  brew bundle --global
  exit 0
fi

