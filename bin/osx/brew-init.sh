#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

ech 'Install XCode Developper Tool'
# Setup homebrew
# Install xcode developper tool
xcode-select --install

if [ -n `which brew` ]; then
  ech 'Skip to install homebrew because it is already installed'
else
  ech 'Install homebrew'
  # Install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Check for success to install homebrew
ech 'Check for success to install homebrew with `brew doctor`'
brew doctor
