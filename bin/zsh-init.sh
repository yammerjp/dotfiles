#!/bin/bash -e

ZSH_PATH="/bin/zsh"

if [ "$SKIP_ZSH_INIT" = "1" ]; then
  echo "Skip to set default shell"
  exit 0
fi

if [ "$SHELL" = "$ZSH_PATH" ]; then
  echo "Your default shell is already zsh"
  exit 0
fi

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi

if ! which "$ZSH_PATH" > /dev/null 2>&1 ; then
  echo "Need zsh"
  echo "Please install zsh and retry this script"
  exit 1
fi

# chsh -s "$ZSH_PATH" "$(users)"
chsh -s "$ZSH_PATH" "$(who | awk ' { print $1 }')"
echo "Chenged."
echo "Please relogin to change shell"

