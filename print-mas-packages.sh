#!/bin/bash -e

BREW_FILE="$HOME/.setup-util/Brewfile"

awk '/^[^#]/ { print } ' "$BREW_FILE" \
  | grep -E '^mas "' \
  | awk -F '"' '{ print $2 }' \
  | xargs echo
