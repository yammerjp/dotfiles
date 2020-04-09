#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }


if ! which brew > /dev/null 2>&1 ; then
  ech "Need homebrew. Prease install homebrew and retry the script."
  exit 1
fi

BREWFILE_CORE="$DOTFILES_DIR/bin/packages-init-macos/brewfile-core"
BREWFILE="$DOTFILES_DIR/bin/packages-init-macos/brewfile"

ech "Install packages in $BREWFILE_CORE"
brew bundle --file "$BREWFILE_CORE"

if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
  ech "Skip to install packages in $BREWFILE"
  exit 0
fi

ech "Install packages in $BREWFILE"
brew bundle --file "$BREWFILE"

