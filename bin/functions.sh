#!/bin/bash

# link
#   hoge:fuga:wara という文字列をつくる
#   hoge:fuga:wara という文字列を hoge fuga wara に分割する
#   hoge/.* となるファイルのリストを作る
#   hoge/.* fuga/.* wara/.* を link_from link_to に変換
#   link_to がuniqueになるようなリストをつくる
#   LINK_TOにファイル/シンボリックリンクが存在するか確認し、存在するなら次のオプションの通りにバックアップをとるなどしてから削除する (オプション, overwrite skip) (オプション: シンボリックリンクでない場合にバックアップを取るかどうか) 
#     LINK_FROM LINK_TO を引数に受け取る
#     LINK_TOにLINK_FROMへのシンボリックリンクがある -> exit
#     LINK_TOにLINK_FROMではない場所へのシンボリックリンクがある -> exit or overwrite
#     LINK_TOに実態ファイルがある -> backupするorしない && exit or overwrite
#   (ファイルが存在しなければ) リストの通りにシンボリックリンクを貼る 

# unlink
#   $HOME/.* というファイル一覧を取得
#   一蘭に対してシンボリックリンクであるものを抽出
#   シンボリックリンク先が DOT_DIRS に含まれる場合、そのシンボリックリンクを削除する

function message() {
  echo "$@" 1>&2
}

function devide_with_colon() {
  COLON_SEPARATED_STRING="$1"

  # shellcheck disable=SC2001
  echo "$COLON_SEPARATED_STRING" | sed "s/:/\n/g"
}

function find_dotfiles() {
  DOTFILES_DIR="$1"

  DOTFILES_DIR_CHAR_LENGTH=${#DOTFILES_DIR}
  # shellcheck disable=SC2004
  find "$DOTFILES_DIR" -type f | cut -c "$(($DOTFILES_DIR_CHAR_LENGTH + 2))-" | sort
}

function link_from_to() {
  DOTFILES_DIR="$1"
  DOTFILES_RELATIVE_PATH="$2"

  LINK_FROM="$DOTFILES_DIR/$DOTFILES_RELATIVE_PATH"
  LINK_TO="$HOME/$DOTFILES_RELATIVE_PATH"
  echo "$LINK_FROM $LINK_TO"
}

function extract_should_link() {
  # /dev/stdin
  # link_from link_to
  # link_from link_to
  # link_from link_to
  # ...

  TMPFILE_EXTRACT_SHOULD_LINK="/tmp/dotfiles_extract_should_link_from_to"
  rm -rf "$TMPFILE_EXTRACT_SHOULD_LINK"
  touch "$TMPFILE_EXTRACT_SHOULD_LINK"

  while read -r LINK_FROM LINK_TO
  do
    # if the same $LINK_TO is not echoed yet
    if ! grep -q "$LINK_TO" "$TMPFILE_EXTRACT_SHOULD_LINK"; then
      echo "$LINK_FROM $LINK_TO"
      echo "$LINK_TO" >> "$TMPFILE_EXTRACT_SHOULD_LINK"
    fi
  done
}

function create_dir() {
  CREATE_DIR_FILE_PATH="$1"
  DIRNAME=$(dirname "$CREATE_DIR_FILE_PATH")
  if [ -d "$DIRNAME" ]; then
    return
  fi
  message "mkdir -p $DIRNAME"
  mkdir -p "$DIRNAME"
}

function evacuate_file() {
  FILE_PATH="$1"

  COUNT=0
  while true;
  do
    EVACUATE_PATH="$FILE_PATH.org${COUNT}"
    if ! [ -e "$EVACUATE_PATH" ]; then
      break;
    fi
    # shellcheck disable=SC2004
    COUNT="$(($COUNT + 1))"
  done

  message "mv -f $FILE_PATH $EVACUATE_PATH"
  mv -f "$FILE_PATH" "$EVACUATE_PATH"
}

function resolve_if_conflict() {
  FILE_PATH="$1"
  ON_CONFLICTION="$2"
  # return 0 ... should be create link
  # return 1 ... should be skip to create link

  # on confliction
  if ! [ -e "$FILE_PATH" ]; then
    return 0
  fi


  case $ON_CONFLICTION in
    # backup old file
    evacuate )
      if [ -L "$FILE_PATH" ];then
        message "delete link from $(readlink "$FILE_PATH") to $FILE_PATH"
        rm "$FILE_PATH"
        return 0
      else
        evacuate_file "$FILE_PATH"
        return 0
      fi
        ;;
    # overwrite old file
    overwrite )
      message "overwrite $FILE_PATH"
      rm "$FILE_PATH"
      return 0
        ;;
    # skip linking
    skip )
      message "file already exists. skip. $FILE_PATH"
      return 1
        ;;
    # error
    * )
      message "ERROR: ON_CONFLICTION is not specified"
      exit 1
        ;;
  esac
}

function dotfiles_list() {
  DOTFILE_DIRS_COLON_SEPARATED="$1"

  devide_with_colon "$DOTFILE_DIRS_COLON_SEPARATED" | while read -r DOTFILES_DIR
  do
    find_dotfiles "$DOTFILES_DIR" | while read -r DOTFILE_RELATIVE_PATH
    do
      link_from_to "$DOTFILES_DIR" "$DOTFILE_RELATIVE_PATH"
    done
  done | extract_should_link
}

function create_link() {
  LINK_FROM="$1"
  LINK_TO="$2"
  ON_CONFLICTION="$3"

  # already exist
  if [ "$(readlink "$LINK_TO")" = "$LINK_FROM" ];then
    message "symlink already exists. $LINK_FROM -> $LINK_TO"
    return
  fi

  create_dir "$LINK_TO"

  if ! resolve_if_conflict "$LINK_TO" "$ON_CONFLICTION"; then
    return 1
  fi

  message "ln -s $LINK_FROM $LINK_TO"
  ln -s "$LINK_FROM" "$LINK_TO"
}

function create_links() {
  DOTFILE_DIRS_COLON_SEPARATED="$1"
  ON_CONFLICTION="$2"

  dotfiles_list "$DOTFILE_DIRS_COLON_SEPARATED" | while read -r LINK_FROM LINK_TO
  do
    create_link "$LINK_FROM" "$LINK_TO" "$ON_CONFLICTION"
  done
}
