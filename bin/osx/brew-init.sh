#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

./echo.sh 'Install XCode Developper Tool'
# Setup homebrew
# Install xcode developper tool
xcode-select --install

./echo.sh 'Install homebrew'
# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Check for success to install homebrew
./echo.sh 'Check for success to install homebrew'
echo "brew doctor"
brew doctor
