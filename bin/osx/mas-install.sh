#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# check to be installed mas
if [ -z `which mas` ]; then
  ./echo.sh 'Need mas-cli'
  exit 1
fi

mas account > /dev/null 2>&1 || result="$?"
if [ "$?" != '0' ]; then
  ./echo.sh 'Need to login to Mac App Store by Apple ID'
  ./echo.sh "Prease retry after logining"
  mas open
  exit 1
fi

./echo.sh 'Install with mas-cli'
MAS_LIST="$SCRIPT_DIR/mas-list"
cat "$MAS_LIST" | while read line
do
  mas install "$line"
done
