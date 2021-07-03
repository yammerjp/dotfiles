#!/bin/bash -e

function message() {
  echo "$@" 1>&2
}

function createLink () {
  LINK_FROM="$1"
  LINK_TO="$2"
  ON_CONFLICTION="$3"

  # create base directories
  DIRNAME=$(dirname "$LINK_TO")
  if ! [ -d "$DIRNAME" ]; then
    message "mkdir -p $DIRNAME"
    mkdir -p "$DIRNAME"
  fi

  if [ "$(readlink "$LINK_TO")" = "$LINK_FROM" ];then
    message "symlink already exists. $LINK_FROM  -> $LINK_TO"
    return
  fi

  # on confliction
  if [ -e "$LINK_TO" ] || [ -L "$LINK_TO" ];then
    case $ON_CONFLICTION in
      evacuate )
        message "mv -f $LINK_TO $LINK_TO.org-dot-deploy"
        mv -f "$LINK_TO" "$LINK_TO.org-dot-deploy"
          ;;
      overwrite )
        message "overwrite $LINK_TO"
        rm -f "$LINK_TO"
          ;;
      skip )
        message "file already exists. $LINK_TO"
        return
          ;;
      * )
        message "ERROR: ON_CONFLICTION is not specified"
        exit 1
          ;;
    esac
  fi

  message "ln -s $LINK_FROM $LINK_TO" 1>&2
  ln -s "$LINK_FROM" "$LINK_TO"
}

function createLinks () {
  ON_CONFLICTION="$1"
  while read -r LINK_FROM LINK_TO
  do
    createLink "$LINK_FROM" "$LINK_TO" "$ON_CONFLICTION"
  done
}

function dotdir2linkingFromAndTo () {
  DOTDIR="$1"
  cd "$DOTDIR"
  find . -type f | while read -r FILE_WITH_DOT_SLASH
  do
    FILE=${FILE_WITH_DOT_SLASH:2} # 先頭の./を取り除く
    
    [[ $FILE =~ ^.git/ ]] && continue
    [[ $FILE =~ ^.github/ ]] && continue
    [[ "$FILE" == ".gitignore" ]] && continue
    [[ "$FILE" == ".DS_Store" ]] && continue
    
    LINK_FROM="$DOTDIR/$FILE"
    LINK_TO="$HOME/$FILE"
    
    echo "$LINK_FROM" "$LINK_TO"
  done
}

function main() {
  ON_CONFLICTION="$1"
  DOTDIRS="${@:2}"

  echo "$ON_CONFLICTION"

  if [ "$ON_CONFLICTION" != 'overwrite' ] && [ "$ON_CONFLICTION" != 'evacuate' ] && [ "$ON_CONFLICTION" != 'skip' ]; then
    message "Usage: $0 overwrite/evacuate/skip <... dotfiles directories>"
    exit 1
  fi

  for DOTDIR in $DOTDIRS
  do
    if ! [ -d "$DOTDIR" ]; then
      continue
    fi
    dotdir2linkingFromAndTo "$DOTDIR" | createLinks "$ON_CONFLICTION"
  done
}

