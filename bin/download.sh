#!/bin/bash -e

function PrintDescription() {
  cat <<-"EOF"



      .o8                .    .o88o.  o8o  oooo                     
     "888              .o8    888 `"  `"'  `888                     
 .oooo888   .ooooo.  .o888oo o888oo  oooo   888   .ooooo.   .oooo.o 
d88' `888  d88' `88b   888    888    `888   888  d88' `88b d88(  "8 
888   888  888   888   888    888     888   888  888ooo888 `"Y88b.  
888   888  888   888   888 .  888     888   888  888    .o o.  )88b 
`Y8bod88P" `Y8bod8P'   "888" o888o   o888o o888o `Y8bod8P' 8""888P' 
                                                                    



EOF
  if [ "$(uname)" = "Linux" ];then
    SUDO="sudo "
  else
    SUDO=""
  fi
  cat <<-EOF
This is basd4g's dotfiles.
Repository: https://github.com/basd4g/dotfiles

Execute the commands to setup this pc.

$ cd ~/dotfiles
$ ${SUDO}make


EOF
}

DOTFILES_DIR="$HOME/dotfiles"

URL_TAR="https://github.com/basd4g/dotfiles/tarball/master"
URL_GIT="https://github.com/basd4g/dotfiles.git"

function DownloadDotfiles() {
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

  echo "Downloaded."
}


# Download dotfiles if it isn't exist.
if [ -d "${DOTFILES_DIR}" ]; then
  echo "Dotfiles already exist."
  echo "${DOTFILES_DIR}"
else
  PrintDescription
  DownloadDotfiles
fi 

if [ "${MAKE_RUN}" = "1" ];then
  cd "${DOTFILES_DIR}"
  make
fi

