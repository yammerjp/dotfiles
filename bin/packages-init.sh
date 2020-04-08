#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

function BrewInstall() {
  PACKAGES_LIST_PATH="$1"
  ech "Install packages in $PACKAGES_LIST_PATH"
  brew bundle --file "$PACKAGES_LIST_PATH"
}

function InstallPackagesForMac() {
 if ! which brew > /dev/null 2>&1 ; then
    ech "Need homebrew. Prease install homebrew and retry the script."
    exit 1
  fi

  BREWFILE_CORE="$DOTFILES_DIR/etc/brewfile-core"
  BREWFILE="$DOTFILES_DIR/etc/brewfile"

  BrewInstall "$BREWFILE_CORE"

  if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
    ech "Skip to install packages in $BREWFILE"
    return 0
  fi

  BrewInstall "$BREWFILE"
}

function AptInstall() {
  PACKAGES_LIST_PATH="$1"
  ech "Install packages in $PACKAGES_LIST_PATH"
  while read -r PACKAGE
  do
    apt install -y "$PACKAGE"
  done < "$PACKAGES_LIST_PATH"
}

function InstallPackagesForUbuntu() {
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

  APTFILE_CORE="$DOTFILES_DIR/etc/aptfile-core"
  APTFILE="$DOTFILES_DIR/etc/aptfile"

  AptInstall "$APTFILE_CORE"

  if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
    ech "Skip to install packages in $APTFILE"
    return 0
  fi

  AptInstall "$APTFILE"
}


if [ "$(uname)" = "Darwin" ];then
  ech "Install packages for macOS"
  InstallPackagesForMac

elif [ "$(uname)" = "Linux" ];then
  ech "Install packages for Linux"
  InstallPackagesForUbuntu
fi

