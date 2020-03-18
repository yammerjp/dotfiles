#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# check to be installed mas
if [ -z `which mas` ]; then
  echo 'Need mas-cli'
  exit 1
fi

mas account > /dev/null 2>&1 || result="$?"
if [ "$?" != '0' ]; then
  echo 'Need to login to Mac App Store by Apple ID'
  echo "Prease retry after logining"
  # mas open
  exit 1
fi

MAS_LIST="$SCRIPT_DIR/mas-list"
cat "$MAS_LIST" | while read line
do
  # mas install "$line"
  echo "mas install $line" 
done
