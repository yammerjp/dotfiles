#!/bin/bash -e
# for GitHub codespaces

if ! command -v git > /dev/null 2>&1; then
  echo "Need git" 1>&2
  exit
fi

if [ "$DOTFILES_REPO" == "" ]; then
  HOME_DOTFILES="$HOME/dotfiles"
  if git -C "$HOME_DOTFILES" ls-files > /dev/null 2>&1 ; then
    DOTFILES_REPO="$HOME_DOTFILES"
  fi
  DOTFILES_REPO="https://github.com/yammerjp/dotfiles"
fi

YADM_PROGRAM="$HOME/yadm"

# setup yadm
curl -fLo "$YADM_PROGRAM" https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x "$YADM_PROGRAM"
"$YADM_PROGRAM" list > /dev/null 2>&1 || "$YADM_PROGRAM" clone "$DOTFILES_REPO"
"$YADM_PROGRAM" checkout ~/
chmod a+x ~/.config/yadm/bootstrap
"$YADM_PROGRAM" bootstrap

# setup packages
bash ~/.setup.sh

