#!/bin/bash

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR/../
DOTFILES_DIR=`pwd`

alias ech="$SCRIPT_DIR/echo.sh"

# symbolic link

find . -type f | grep -E "^\./\." | while read FILE_WITH_DOT_SLASH
do
  FILE=${FILE_WITH_DOT_SLASH:2} # 先頭の./を取り除く
  DIRNAME=`dirname "$FILE"`

  [[ $FILE =~ ^.git/ ]] && continue
  [[ "$FILE" == ".gitignore" ]] && continue
  [[ "$FILE" == ".DS_Store" ]] && continue

  if [ "$DIRNAME" != "." ];then
    echo "mkdir -p $DIRNAME" # ディレクトリを掘る
    mkdir -p $DIRNAME
  fi

  LINK_FROM="$DOTFILES_DIR/$FILE"
  LINK_TO="$HOME/$FILE"
  LINK_TO_BACKUP="$HOME/$FILE.org-dot-deploy"

  if [ `readlink $LINK_TO` = $LINK_FROM ];then
    echo "symlink is already put. $LINK_FROM  -> $LINK_TO"
    continue
  fi

  if [ -e $LINK_FROM ];then
    echo "mv -f $LINK_TO $LINK_TO_BACKUP"
    mv -f "$LINK_TO" "$LINK_TO_BACKUP"
  fi

  echo "ln -s $LINK_FROM $LINK_TO"
  ln -s "$LINK_FROM" "$LINK_TO"
done

