#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

ZSH_PATH="/bin/zsh"

if [ "$SHELL" = "$ZSH_PATH" ]; then
  ech "Your login shell is already zsh"
  exit 0
fi

ech "Install packages for Linux"
if [ "$(whoami)" != "root" ]; then
  ech "Require root privilege"
  exit 1
fi

if ! which "$ZSH_PATH" > /dev/null 2>&1 ; then
  ech "Need zsh"
  exit 1
fi

chsh -s "$ZSH_PATH" "$(users)"

exit 0

