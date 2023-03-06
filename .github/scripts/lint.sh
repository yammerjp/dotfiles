#!/bin/bash

git ls-files | while read -r dotfile
do
  if [[ "$dotfile" =~ \.sh$ ]]; then
    echo shellcheck "$dotfile"
    shellcheck "$dotfile"
  elif [[ "$(head -1 "$dotfile")" =~ ^#!/bin/(ba)?sh ]]; then
    echo shellcheck "$dotfile"
    shellcheck "$dotfile"
  fi
done
