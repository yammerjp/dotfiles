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

  if type "git" > /dev/null 2>&1 ; then
    echo "with git"
    git clone --recursive "${URL_GIT}" "${DOTFILES_DIR}"
  elif type "curl" > /dev/null 2>&1 ; then
    echo "with curl"
    mkdir "${DOTFILES_DIR}"
    curl -fsSL "${URL_TAR}" | tar xz  --strip-components 1 -C "${DOTFILES_DIR}"
  elif type "wget" > /dev/null 2>&1 ; then
    echo "with wget"
    mkdir "${DOTFILES_DIR}"
    wget "${URL_TAR}" --quiet -O - | tar xz  --strip-components 1 -C "${DOTFILES_DIR}"
  else
    echo "Need git or curl or wget."
    exit 1
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

