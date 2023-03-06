#!/bin/bash

set -e

if which yadm > /dev/null; then
  YADM_PROGRAM="$(which yadm)"
else
  # setup yadm
  mkdir -p "$HOME/.local/bin"
  YADM_PROGRAM="$HOME/.local/bin/yadm"
  curl -fLo "$YADM_PROGRAM" https://github.com/TheLocehiliosan/yadm/raw/master/yadm
  chmod a+x "$YADM_PROGRAM"
fi

# clone dotfiles repository
# shellcheck disable=SC2097,SC2098
if ! "$YADM_PROGRAM" list -a > /dev/null 2>&1 ; then
  YADM_PROGRAM="$YADM_PROGRAM" "$YADM_PROGRAM" clone "${DOTFILES_REPO:-https://github.com/yammerjp/dotfiles}" --bootstrap
fi

if [ "$CODE_SPACES" == "true" ]; then
  echo -e "Hello, yammerjp's dotfiles in Codespaces!\nPackage isntallation is skipped."
  exit 0
fi

#### SETUP PACKAGES
case "$(uname -v)" in
  Darwin*)
    # shellcheck disable=SC1090
    "$HOME/setup-darwin.sh"
    ;;
  *Ubuntu*)
    # shellcheck disable=SC1090
    "$HOME/setup-ubuntu.sh"
    ;;
  *)
    echo "setup script is not found..."
    ;;
esac
