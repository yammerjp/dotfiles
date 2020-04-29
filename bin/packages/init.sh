#!/bin/bash -e

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

echo "Build and Install packages"
bash "$SCRIPT_DIR/common.sh" "$1"

if [ "$(uname)" = "Darwin" ];then
  echo "Install packages for macOS"
  bash "$SCRIPT_DIR/macos.sh" "$1"

elif [ "$(uname)" = "Linux" ];then
  echo "Install packages for Ubuntu"
  bash "$SCRIPT_DIR/ubuntu.sh" "$1"
fi

