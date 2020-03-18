#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# Setup homebrew
# Install xcode developper tool
xcode-select --install

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Check for success to install homebrew
echo "brew doctor"
brew doctor
