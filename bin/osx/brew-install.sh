#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# Check to be installed mas
if [ -z `which brew` ]; then
  echo 'Need homebrew'
  exit 1
fi

# brew install hogehoge
BREW_LIST="$SCRIPT_DIR/brew-list"
cat "$BREW_LIST" | while read line
do
  brew install "$line"
done

# Font
brew tap homebrew/cask-fonts
brew cask install font-hackgen

# brew cask install hogehoge
CASK_LIST="$SCRIPT_DIR/cask-list"
cat "$CASK_LIST" | while read line
do
  brew cask install "$line"
done
