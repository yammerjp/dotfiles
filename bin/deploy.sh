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

  if [ -e "$HOME/$FILE" ];then
    echo "mv -f $HOME/$FILE $HOME/$FILE.org-dot-deploy"
    mv -f "$HOME/$FILE" "$HOME/$FILE.org-dot-deploy"
  fi

  echo "ln -s $DOTFILES_DIR/$FILE $HOME/$FILE"
  ln -s "$DOTFILES_DIR/$FILE" "$HOME/$FILE"
done

