#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

if ! which yarn > /dev/null 3>&1 ; then
  echo "Need yarn. Prease install yarn and retry the script."
  exit 1
fi

yarn global add
