#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# check to be installed mas
if [ -z `which mas` ]; then
  ./echo.sh 'Need mas-cli'
  exit 1
fi

mas account > /dev/null 2>&1
if [ "$?" != '0' ]; then
  ./echo.sh 'Need to login to Mac App Store by Apple ID'
  ./echo.sh "Prease retry after logining"
  mas open
  exit 1
fi

./echo.sh 'Install with mas-cli'
MAS_LIST_PATH="$SCRIPT_DIR/mas-list"
cat "$MAS_LIST_PATH" | awk '{ print $1 }' | while read line
do
  mas list | awk '{ print $1 }' | grep -E "^$line$" > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    ./echo.sh "  Skip to install package $line because it is Already installed"
    continue
  fi
  ./echo.sh "  Install package $line"
  mas install "$line"
done
