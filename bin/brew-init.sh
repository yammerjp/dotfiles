#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

DOT_DIRECTORY="${HOME}/dotfiles"

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

function CheckOSType () {
  if [ $(uname) != "Darwin" ];then
    ech "Your computer is not macOS"
    ech "Abort to setup"
    exit
  fi
}

function InstallXcodeDevTool () {
  ech "Install XCode-developper tool"
  while :
  do
    xcode-select -v
    if [ "$?" = '0' ]; then
      break
    fi
    ech "Need command line tools for xcode"
    xcode-select -install

    ech "If you finish to install 'command line tools for xcode', Prease press Enter key"
    read hoge
  done
}

function InstallBrew () {
  ech "Install homebrew"
  while :
  do
    which brew
    if [ "$?" = '0' ]; then
      break
    fi
    ech "Need homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ech "If you finish to install 'homebrew', Prease press Enter key"
    read hoge
  done
}
 
CheckOSType
InstallXcodeDevTool
InstallBrew
