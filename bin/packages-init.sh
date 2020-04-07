#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

if [ "$(uname)" = "Darwin" ];then
  ech "Install packages for macOS"
  if ! which brew > /dev/null 2>&1 ; then
    ech "Need homebrew. Prease install homebrew and retry the script."
    exit 1
  fi

 brew bundle --file "$DOTFILES_DIR/etc/brewfile-core"
 if [ "$BREW_BUNDLE_CORE_ONLY" = "1" ]; then
  exit 0
 fi
 brew bundle --file "$DOTFILES_DIR/etc/brewfile"

fi

