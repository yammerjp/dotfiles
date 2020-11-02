#!/bin/bash -e

if [ "$(whoami)" = "root" ]; then
  echo "The script must be running without root."
  exit 1
fi

DOTFILES_DIR="$HOME/dotfiles"
if [ -d "${DOTFILES_DIR}" ]; then
  echo "Dotfiles is already exist."
  echo "${DOTFILES_DIR}"
  exit 0
fi

cat <<-"EOF"



      .o8                .    .o88o.  o8o  oooo                     
     "888              .o8    888 `"  `"'  `888                     
 .oooo888   .ooooo.  .o888oo o888oo  oooo   888   .ooooo.   .oooo.o 
d88' `888  d88' `88b   888    888    `888   888  d88' `88b d88(  "8 
888   888  888   888   888    888     888   888  888ooo888 `"Y88b.  
888   888  888   888   888 .  888     888   888  888    .o o.  )88b 
`Y8bod88P" `Y8bod8P'   "888" o888o   o888o o888o `Y8bod8P' 8""888P' 
                                                                    



This is basd4g's dotfiles.
Repository: https://github.com/basd4g/dotfiles

Downloading dotfiles...
EOF


URL_TAR="https://github.com/basd4g/dotfiles/tarball/master"
URL_GIT="https://github.com/basd4g/dotfiles.git"

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
  echo "Need git, curl or wget."
  exit 1
fi


echo -e "Downloaded.\n\n"
echo -e "Execute the commands to setup this pc.\n\n"
echo    "$ cd ~/dotfiles"

if [ "$(uname)" = "Linux" ];then
  echo -e "$ sudo make\n\n"
else
  echo -e "$ make\n\n"
fi
