#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

DOT_DIRECTORY="${HOME}/dotfiles"

#sh brew-init.sh
#sh brew-install.sh
#sh mas-install.sh

#sh deploy.sh
if [ $(uname) != "Darwin" ];then
  ech "Your computer is not macOS"
  ech "Abort to setup"
  exit
fi

ech "Install XCode-developper tool"

while :
do
  xcode-select -v
  if [ "$?" = 0 ]; then
    break
  fi
  ech "Need command line tools for xcode"
  xcode-select -install

  ech "If you finish to install 'command line tools for xcode', Prease press Enter key"

done
