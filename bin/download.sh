#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"

URL_TAR="https://github.com/basd4g/dotfiles/tarball/master"
URL_GIT="https://github.com/basd4g/dotfiles.git"

# Download dotfiles if it isn't exist.
if [ -d "${DOTFILES_DIR}" ]; then
  echo "Dotfiles already exist."
  echo "${DOTFILES_DIR}"
else
  echo "Downloading dotfiles..."
  mkdir "${DOTFILES_DIR}"

  
  if type "git" > /dev/null 2>&1 && : ; then
    git clone --recursive "${URL_GIT}" "${DOTFILES_DIR}"
  else
    # Download dotfiles without git
    curl -fsSLo "${HOME}/dotfiles.tar.gz" "${URL_TAR}"
    tar -zxf "${HOME}/dotfiles.tar.gz" --strip-components 1 -C "${DOTFILES_DIR}"
    rm -f "${HOME}/dotfiles.tar.gz"
  fi

  echo "$(tput setaf 2)Download dotfiles complete!. $(tput sgr0)"
fi 

if [ "${MAKE_RUN}" = "1" ];then
  cd "${DOTFILES_DIR}"
  make run
fi
