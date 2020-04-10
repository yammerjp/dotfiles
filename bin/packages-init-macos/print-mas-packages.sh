#!/bin/bash -e

BREW_FILE="$HOME/dotfiles/.Brewfile"

awk '/^[^#]/ { print } ' "$BREW_FILE" \
  | grep -E '^mas "' \
  | awk -F '"' '{ print $2 }' \
  | xargs echo
