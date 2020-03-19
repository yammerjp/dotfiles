#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

alias ech="$SCRIPT_DIR/echo.sh"

DOT_DIRECTORY="${HOME}/dotfiles"

DOT_TARBALL="https://github.com/basd4g/dotfiles/tarball/master"
REMOTE_URL="https://github.com/basd4g/dotfiles.git"

# Download dotfiles if it isn't exist.
if [ -d ${DOT_DIRECTORY} ]; then
  ech "Dotfiles already exist."
  ech "${DOT_DIRECTORY}"
else
  ech "Downloading dotfiles..."
  mkdir ${DOT_DIRECTORY}

  
  if type "git" > /dev/null 2>&1; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    # Download dotfiles without git
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi

  ech $(tput setaf 2)Download dotfiles complete!. $(tput sgr0)
fi 

# sh ~/dotfiles/bin/deploy.sh
# 自動でデプロイはとりあえず無効化
# cd ~/dotfiles && make deploy でデプロイ
