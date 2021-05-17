#!/bin/bash -e

DOTFILES_DIR=$(cd "$(dirname "$0")/../" ; pwd)
cd "$DOTFILES_DIR"

find . -type f | grep -E "^\./\." | while read -r FILE_WITH_DOT_SLASH
do
  FILE=${FILE_WITH_DOT_SLASH:2} # 先頭の./を取り除く
  DIRNAME=$(dirname "$FILE")

  [[ $FILE =~ ^.git/ ]] && continue
  [[ $FILE =~ ^.github/ ]] && continue
  [[ "$FILE" == ".gitignore" ]] && continue
  [[ "$FILE" == ".DS_Store" ]] && continue

  if [ "$DIRNAME" != "." ];then
    echo "mkdir -p $HOME/$DIRNAME" # ディレクトリを掘る
    mkdir -p "$HOME/$DIRNAME"
  fi

  LINK_FROM="$DOTFILES_DIR/$FILE"
  LINK_TO="$HOME/$FILE"
  LINK_TO_BACKUP="$HOME/$FILE.org-dot-deploy"

  if LINK_ALREADY_EXISTS=$(readlink "$LINK_TO") && [ "$LINK_ALREADY_EXISTS" = "$LINK_FROM" ];then
    echo "symlink already exist. $LINK_FROM  -> $LINK_TO"
    continue
  fi

  if [ -e "$LINK_TO" ];then
    echo "mv -f $LINK_TO $LINK_TO_BACKUP"
    mv -f "$LINK_TO" "$LINK_TO_BACKUP"
  fi

  echo "ln -s $LINK_FROM $LINK_TO"
  ln -s "$LINK_FROM" "$LINK_TO"
done
