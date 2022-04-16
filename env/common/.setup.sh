#!/bin/bash -e

OS="$(uname -s)"          # Darwin Linux
DIST="$(os_distribution)" # Ubuntu         # allow empty

if [ "$OS" = Darwin ]; then
  source ~/.config/yammerjp/setup-darwin.sh
elif [ "$OS" = Linux ] && [ "$DIST" = Ubuntu ]; then
  source ~/.config/yammerjp/setup-linux-ubuntu.sh
else
  echo "setup script is not found..." 1&>2
fi
