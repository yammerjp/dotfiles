#!/bin/bash -e

DOTFILES_DIR=$(cd $(dirname $0)/../../; pwd)

if ! which brew > /dev/null 2>&1 ; then
  echo "Need homebrew. Prease install homebrew and retry the script."
  exit 1
fi

echo "Install packages"

if [ "$1" = "minimum" ]; then
  brew bundle --file "$DOTFILES_DIR/etc/Brewfile-mini"
  echo "Finished minimum packages"
  exit 0
fi

brew bundle --file "$DOTFILES_DIR/etc/Brewfile"

