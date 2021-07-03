#!/bin/bash -e

function distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other 
    echo 'Ubuntu'
    return
  fi
}

REPO="yammerjp/dotfiles"
DOTFILES_DIR="$HOME/src/github.com/$REPO"

OS="$(uname -s)"       # Darwin Linux
ARCH="$(uname -m)"     # arm64 x86_64
DIST="$(distribution)" # Ubuntu


function dotdirs() {
  if [ "$ARCH" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS-$DIST-$ARCH"
  fi
  if [ "$DIST" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS-$DIST"
  fi
  if [ "$OS" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS"
  fi
  echo "$DOTFILES_DIR/env/common"
}

# example: 
#   $DOTFILES_DIR/env/common
#   $DOTFILES_DIR/env/Darwin
#   $DOTFILES_DIR/env/Darwin--x86_64
#   
#   $DOTFILES_DIR/env/common
#   $DOTFILES_DIR/env/Darwin
#   $DOTFILES_DIR/env/Darwin--arm64
#   
#   $DOTFILES_DIR/env/common
#   $DOTFILES_DIR/env/Linux
#   $DOTFILES_DIR/env/Linux-Ubuntu
#   $DOTFILES_DIR/env/Linux-Ubuntu-x86_64

dotdirs
