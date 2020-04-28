#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"


# sourcekit-lsp
#if ! which sourcekit-lsp > /dev/null 2>&1 ; then
#  echo "Install sourcekit-lsp (lsp for swift)"
#  git clone https://github.com/apple/sourcekit-lsp.git /tmp/sourcekit-lsp
#  cd /tmp/sourcekit-lsp
#  swift build -c release
#  mv .build/release/sourcekit-lsp /usr/local/bin
#  echo "Finished sourcekit-lsp"
#fi

