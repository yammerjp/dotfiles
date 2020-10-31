#!/bin/bash -e

DOTFILES_DIR=$(cd "$(dirname "$0")/../" ; pwd)

if ! command -v brew > /dev/null 2>&1 ; then
  echo "Need homebrew. Prease install homebrew and retry the script."
  exit 1
fi

echo "Install packages"

brew bundle --file "$DOTFILES_DIR/etc/Brewfile-mini"
echo "Finished minimum packages"

if [ "$1" = "minimum" ]; then
  exit 0
fi

brew bundle --file "$DOTFILES_DIR/etc/Brewfile"

