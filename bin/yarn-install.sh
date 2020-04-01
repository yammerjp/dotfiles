#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

# check to be installed yarn 
if [ -z `which yarn` ]; then
  ech 'Need yarn'
  exit 1
fi

ech 'Install with yarn'
YARN_LIST_PATH="$SCRIPT_DIR/yarn-list"
cat "$YARN_LIST_PATH" | awk '{ print $1 }' | while read line
do
  yarn global list \
    | grep -E "^info \"${line}(@[.0-9]+)?\" has binaries:" > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    ech "  Skip to install package $line because it is Already installed"
    continue
  fi
  ech "  Install package $line"
#  yarn global add "$line"
done
