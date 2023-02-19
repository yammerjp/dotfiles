#!/bin/bash

set -e

#### SETUP DOTFILES

# find dotfiles repository
if [ "$DOTFILES_REPO" == "" ]; then
  DOTFILES_REPO="https://github.com/yammerjp/dotfiles"
fi

# setup yadm
mkdir -p "$HOME/.local/bin"
YADM_PROGRAM="$HOME/.local/bin/yadm"
curl -fLo "$YADM_PROGRAM" https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x "$YADM_PROGRAM"

# clone dotfiles repository
# shellcheck disable=SC2097,SC2098
if ! "$YADM_PROGRAM" list -a > /dev/null 2>&1 ; then
  YADM_PROGRAM="$YADM_PROGRAM" "$YADM_PROGRAM" clone "$DOTFILES_REPO" --bootstrap
fi

#### SETUP PACKAGES
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
  "$HOME/setup-darwin.sh"
elif [ "$OS" = Linux ] && [ "$DIST" = Ubuntu ]; then
  # shellcheck disable=SC1090
  "$HOME/setup-ubuntu.sh"
else
  echo "setup script is not found..."
fi
