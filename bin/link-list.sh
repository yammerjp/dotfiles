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
  DOTDIRS=""
  if [ "$ARCH" != "" ]; then
    DOTDIRS="$DOTFILES_DIR/env/$OS-$DIST-$ARCH"
  fi
  if [ "$DIST" != "" ]; then
    DOTDIRS="$DOTDIRS:$DOTFILES_DIR/env/$OS-$DIST"
  fi
  if [ "$OS" != "" ]; then
    DOTDIRS="$DOTDIRS:$DOTFILES_DIR/env/$OS"
  fi
  DOTDIRS="$DOTDIRS:$DOTFILES_DIR/env/common"
  echo "$DOTDIRS"
}

# example: 
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin--x86_64
#
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin--arm64
#   
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Linux:$HOME/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu:$HOME/src/github.com/yammerjp/dotfiles/Linux-Ubuntu-x86_64

dotdirs
