#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

alias ech="../echo.sh"

# check to be installed mas
if [ -z `which mas` ]; then
  ech 'Need mas-cli'
  exit 1
fi

mas account > /dev/null 2>&1
if [ "$?" != '0' ]; then
  ech 'Need to login to Mac App Store by Apple ID'
  ech "Prease retry after logining"
  mas open
  exit 1
fi

ech 'Install with mas-cli'
MAS_LIST_PATH="$SCRIPT_DIR/mas-list"
cat "$MAS_LIST_PATH" | awk '{ print $1 }' | while read line
do
  mas list | awk '{ print $1 }' | grep -E "^$line$" > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    ech "  Skip to install package $line because it is Already installed"
    continue
  fi
  ech "  Install package $line"
  mas install "$line"
done
