#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

echo "Build and Install packages"
bash "packages-init/common.sh" "$1"

if [ "$(uname)" = "Darwin" ];then
  echo "Install packages for macOS"
  bash "packages-init/macos.sh" "$1"

elif [ "$(uname)" = "Linux" ];then
  echo "Install packages for Ubuntu"
  bash "packages-init/ubuntu.sh" "$1"
fi

