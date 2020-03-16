#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

DOT_DIRECTORY="${HOME}/dotfiles"

DOT_TARBALL="https://github.com/basd4g/dotfiles/tarball/master"
REMOTE_URL="https://github.com/basd4g/dotfiles.git"

# Download dotfiles if it isn't exist.
if [ ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  mkdir ${DOT_DIRECTORY}

  
  if type "git" > /dev/null 2>&1; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    # Download dotfiles without git
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi

  echo $(tput setaf 2)Download dotfiles complete!. $(tput sgr0)

else
  echo "Dotfiles already exist."
  echo "${DOT_DIRECTORY}"
fi 
