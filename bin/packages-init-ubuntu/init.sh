#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

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

APTFILE_CORE="$DOTFILES_DIR/bin/packages-init-ubuntu/aptfile-core.sh"
APTFILE="$DOTFILES_DIR/bin/packages-init-ubuntu/aptfile.sh"

ech "Install packages in $APTFILE_CORE"
bash "$APTFILE_CORE"

if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
  ech "Skip to install packages in $APTFILE"
  exit 0
fi

ech "Install packages in $APTFILE"
bash "$APTFILE"

