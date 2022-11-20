#!/bin/bash -e
# for GitHub codespaces

if ! command -v git > /dev/null 2>&1; then
  echo "Need git" 1>&2
  exit
fi

# find dotfiles repository
if [ "$DOTFILES_REPO" == "" ]; then
  HOME_DOTFILES="$HOME/dotfiles/.git"
  if git -C "$HOME_DOTFILES" ls-files > /dev/null 2>&1 ; then
    # CI and Docker
    DOTFILES_REPO="$HOME_DOTFILES"
  else
    # other
    DOTFILES_REPO="https://github.com/yammerjp/dotfiles"
  fi
  echo "dotfiles-repo: $DOTFILES_REPO"
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

