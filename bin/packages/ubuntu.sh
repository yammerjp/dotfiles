#!/bin/bash -e

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

echo "Install packages"

bash "$SCRIPT_DIR/ubuntu-cui.sh"

if [ "$1" != "minimum" ]; then
  bash "$SCRIPT_DIR/ubuntu-gui.sh"
fi
