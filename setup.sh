#!/bin/bash -e
# for GitHub codespaces

if ! command -v git > /dev/null 2>&1; then
  echo "Need git" 1>&2
  exit
fi

# find dotfiles repository
if [ "$DOTFILES_REPO" == "" ]; then
  DOTFILES_REPO="https://github.com/yammerjp/dotfiles"
fi

# setup yadm
mkdir -p "$HOME/.local/bin"
YADM_PROGRAM="$HOME/.local/bin/yadm"
curl -fLo "$YADM_PROGRAM" https://github.com/TheLocehiliosan/yadm/raw/master/yadm \
  && chmod a+x "$YADM_PROGRAM"

# clone dotfiles repository
# shellcheck disable=SC2097,SC2098
"$YADM_PROGRAM" list -a > /dev/null 2>&1 \
  || YADM_PROGRAM="$YADM_PROGRAM" "$YADM_PROGRAM" clone "$DOTFILES_REPO" --bootstrap

# setup packages
bash ~/.setup.sh

