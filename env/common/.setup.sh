#!/bin/bash -e

OS="$(uname -s)"          # Darwin Linux
DIST="$(os_distribution)" # Ubuntu         # allow empty

if [ "$OS" = Darwin ]; then
  # shellcheck disable=SC1090
  source "$HOME/.config/yammerjp/setup-darwin.sh"
elif [ "$OS" = Linux ] && [ "$DIST" = Ubuntu ]; then
  # shellcheck disable=SC1090
  source "$HOME/.config/yammerjp/setup-linux-ubuntu.sh"
else
  echo "setup script is not found..."
fi
