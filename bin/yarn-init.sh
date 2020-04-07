#!/bin/bash -e

# change directory to the shell file's directory
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
cd "$SCRIPT_DIR"

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

if ! which yarn > /dev/null 2>&1 ; then
  ech "Need yarn. Prease install yarn and retry the script."
  exit 1
fi

yarn global add
