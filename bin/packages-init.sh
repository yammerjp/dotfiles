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

elif [ "$(uname)" = "Linux" ];then

  ech "Install packages for Linux"
  if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"
    exit 1
  fi
  if ! which apt > /dev/null 2>&1 ; then
    ech "Need apt"
    exit 1
  fi

  curl -sL https://deb.nodesource.com/setup_13.x | bash -
  apt update
  apt upgrade -y

  cat "$DOTFILES_DIR/etc/aptfile" | while read -r PACKAGE
  do
    apt-get install -y "$PACKAGE"
  done

  exit 0
fi

