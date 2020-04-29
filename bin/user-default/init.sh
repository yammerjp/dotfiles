#!/bin/bash -e

if [ "$(uname)" != "Darwin" ];then
  exit 0
fi

echo  "Set User Default with 'defaults' command"

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

bash "$SCRIPT_DIR/os.sh"
# Please execute ~/dotfiles/bin/user-default/shiftit.sh after first booting shiftit.
# bash "$SCRIPT_DIR/shiftit.sh"

