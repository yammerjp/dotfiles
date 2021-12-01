#!/bin/bash -e

function distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other 
    echo 'Ubuntu'
    return
  fi
}


OS="$(uname -s)"       # Darwin Linux
ARCH="$(uname -m)"     # arm64 x86_64
DIST="$(distribution)" # Ubuntu

function dotdirs_with_line_break() {
  REPO="yammerjp/dotfiles"
  DOTFILES_DIR="$HOME/src/github.com/$REPO"

  if [ "$ARCH" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS-$DIST-$ARCH"
  fi
  if [ "$DIST" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS-$DIST"
  fi
  if [ "$OS" != "" ]; then
    echo "$DOTFILES_DIR/env/$OS"
  fi
  echo -n "$DOTFILES_DIR/env/common"
}

function dotdirs() {
  dotdirs_with_line_break | \
   # /usr/bin/awk 'NR==1{printf "%s", $0} NR!=1{printf ":%s", $0}'
    tr '\n' ':'
}

# example: 
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin--x86_64
#
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin:$HOME/src/github.com/yammerjp/dotfiles/env/Darwin--arm64
#   
#   $HOME/src/github.com/yammerjp/dotfiles/env/common:$HOME/src/github.com/yammerjp/dotfiles/env/Linux:$HOME/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu:$HOME/src/github.com/yammerjp/dotfiles/Linux-Ubuntu-x86_64
