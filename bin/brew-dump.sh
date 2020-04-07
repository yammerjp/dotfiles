#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

DUMP_FILE="$DOTFILES_DIR/etc/brewfile"
DUMP_FILE_TMP="/tmp/brewfile-dump"

if which brew;
  ech "Need homebrew."
  exit 1
fi

brew bundle dump --force --file "$DUMP_FILE_TMP"

awk '/^[^#]/ { print } ' "$DOTFILES_DIR/etc/brewfile-core" \
  | diff --new-line-format='%L' --unchanged-line-format='' - "$DUMP_FILE_TMP" \
  | tee "$DUMP_FILE" 1> /dev/null

rm "$DUMP_FILE_TMP"

ech "$DUMP_FILE is updated"
