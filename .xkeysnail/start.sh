#!/bin/bash -e

if grep -E "^xkeysnail:" /etc/passwd; then
  SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
  xhost +SI:localuser:xkeysnail
  exec sudo -u xkeysnail xkeysnail "$SCRIPT_DIR/config.py"
fi

