#!/bin/bash -e

function removeLinks() {
  DOTDIR="$1"
  cd

  # skip checking do any symlinks exists or not, in following the directories, for more fast.
  # ~/src/**/*    ~/.cache/**/*    ~/.rbenv/**/*
  find . -type l | grep -v "^\./\.src" | grep -v "^\./\.cache" | grep -v "^\./\.rbenv" | while read -r FILE_WITH_DOT_SLASH
  do
    FILE=${FILE_WITH_DOT_SLASH:2} # 先頭の./を取り除く
  
    if [[ "$(readlink "$HOME/$FILE")" == "$DOTDIR"* ]]; then
      echo "delete link of $HOME/$FILE" 1>&2
      rm "$HOME/$FILE"
    fi
  done
}

function main() {
  if [ "$1" = '' ]; then
    echo "Usage: $0 <... dotfiles directories>"  1>&2
    exit 1
  fi

  for DOTDIR in "$@"
  do
    removeLinks "$DOTDIR"
  done
}
