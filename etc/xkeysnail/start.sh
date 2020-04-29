#!/bin/bash -e

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit 0; pwd)
if [ "$SCRIPT_DIR" = "0" ]; then
  echo "Getting script directory is failed."
  exit 1
fi

if ! [ -x "$(command -v xkeysnail)" ]; then
  echo "Please install xkeysnail."
  exit 0
fi

xhost +SI:localuser:xkeysnail

if ps -a | grep xkeysnail 2>&1 /dev/null ; then
  echo "xkeysnail is already started."
  exit 0
fi

sudo -u xkeysnail DISPLAY=:0 xkeysnail "$SCRIPT_DIR/config.py" &

