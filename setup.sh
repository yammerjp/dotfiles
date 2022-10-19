#!/bin/bash -e
# for GitHub codespaces

if ! which git > /dev/null 2>&1; then
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

# setup yadm
curl -fLo ~/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x ~/yadm
~yadm list > /dev/null 2>&1 || ~/yadm clone "$DOTFILES_REPO"
~/yadm clone
~/yadm bootstrap

# setup packages
bash ~/.setup.sh

