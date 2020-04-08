#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

ZSH_PATH="/bin/zsh"

ech "Chenge default shell to zsh"

if [ "$SHELL" = "$ZSH_PATH" ]; then
  ech "Your default shell is already zsh"
  exit 0
fi

if [ "$(whoami)" != "root" ]; then
  ech "Require root privilege"
  exit 1
fi

if ! which "$ZSH_PATH" > /dev/null 2>&1 ; then
  ech "Need zsh"
  ech "Please install zsh and retry this script"
  exit 1
fi

chsh -s "$ZSH_PATH" "$(users)"
ech "Chenged."
ech "Please relogin to change shell"

