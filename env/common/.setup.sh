#!/bin/bash -e

function os_distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other
    echo 'Ubuntu'
    return
  fi
}

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
