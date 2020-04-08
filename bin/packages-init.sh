#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

function BrewInstall() {
 if ! which brew > /dev/null 2>&1 ; then
    ech "Need homebrew. Prease install homebrew and retry the script."
    exit 1
  fi

 brew bundle --file "$DOTFILES_DIR/etc/brewfile-core"
 if [ "$BREW_BUNDLE_CORE_ONLY" = "1" ]; then
  return 0
 fi

 brew bundle --file "$DOTFILES_DIR/etc/brewfile"
}

function AptInstall() {
 if [ "$(whoami)" != "root" ]; then
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

  while read -r PACKAGE
  do
    apt install -y "$PACKAGE"
  done < "$DOTFILES_DIR/etc/aptfile"
}


if [ "$(uname)" = "Darwin" ];then
  ech "Install packages for macOS"
  BrewInstall
  exit 0

elif [ "$(uname)" = "Linux" ];then

  ech "Install packages for Linux"
  AptInstall
  exit 0
fi

