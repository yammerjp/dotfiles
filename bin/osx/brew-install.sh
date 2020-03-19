#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# Check to be installed mas
if [ -z `which brew` ]; then
  ./echo.sh 'Error. Need homebrew'
  exit 1
fi

./echo.sh 'Install packages with brew'
# brew install hogehoge
BREW_LIST="$SCRIPT_DIR/brew-list"
cat "$BREW_LIST" | while read line
do
  brew install "$line"
done

./echo.sh 'Install font-hackgen with brew'
# Font
brew tap homebrew/cask-fonts
brew cask install font-hackgen

./echo.sh 'Install packages with brew-cask'
# brew cask install hogehoge
CASK_LIST="$SCRIPT_DIR/cask-list"
cat "$CASK_LIST" | while read line
do
  brew cask install "$line"
done
