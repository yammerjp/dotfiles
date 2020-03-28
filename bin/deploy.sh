#!/bin/bash

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

cd ..
DOTFILES_DIR=`pwd`

# symbolic link

find . -type f | grep -E "^\./\." | while read FILE_WITH_DOT_SLASH
do
  FILE=${FILE_WITH_DOT_SLASH:2} # 先頭の./を取り除く
  DIRNAME=`dirname "$FILE"`

  [[ $FILE =~ ^.git/ ]] && continue
  [[ "$FILE" == ".gitignore" ]] && continue
  [[ "$FILE" == ".DS_Store" ]] && continue

  if [ "$DIRNAME" != "." ];then
    ech "mkdir -p $DIRNAME" # ディレクトリを掘る
    mkdir -p $DIRNAME
  fi

  LINK_FROM="$DOTFILES_DIR/$FILE"
  LINK_TO="$HOME/$FILE"
  LINK_TO_BACKUP="$HOME/$FILE.org-dot-deploy"

  if [ `readlink $LINK_TO` = $LINK_FROM ];then
    ech "symlink already exist. $LINK_FROM  -> $LINK_TO"
    continue
  fi

  if [ -e $LINK_FROM ];then
    ech "mv -f $LINK_TO $LINK_TO_BACKUP"
    mv -f "$LINK_TO" "$LINK_TO_BACKUP"
  fi

  ech "ln -s $LINK_FROM $LINK_TO"
  ln -s "$LINK_FROM" "$LINK_TO"
done

