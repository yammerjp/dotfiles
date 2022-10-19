#!/bin/bash -e

if [ "$(whoami)" = "root" ]; then
  echo "The script must be running without root."
  exit 1
fi

REPO="yammerjp/dotfiles"

DOTFILES_DIR="$HOME/src/github.com/$REPO"
if [ -d "${DOTFILES_DIR}" ]; then
  echo "Dotfiles is already exist."
  echo "${DOTFILES_DIR}"
else

cat <<-"EOF"



      .o8                .    .o88o.  o8o  oooo                     
     "888              .o8    888 `"  `"'  `888                     
 .oooo888   .ooooo.  .o888oo o888oo  oooo   888   .ooooo.   .oooo.o 
d88' `888  d88' `88b   888    888    `888   888  d88' `88b d88(  "8 
888   888  888   888   888    888     888   888  888ooo888 `"Y88b.  
888   888  888   888   888 .  888     888   888  888    .o o.  )88b 
`Y8bod88P" `Y8bod8P'   "888" o888o   o888o o888o `Y8bod8P' 8""888P' 
                                                                    



This is yammerjp's dotfiles.
Repository: https://github.com/yammerjp/dotfiles

Downloading dotfiles...
EOF

git clone "https://github.com/$REPO.git" "${DOTFILES_DIR}"

echo -e "Downloaded.\n\n"

fi

LINK_CMD="${DOTFILES_DIR}/.bin/dotfiles link"
SETUP_CMD="${DOTFILES_DIR}/.bin/dotfiles setup"

if [ "$DOTFILES_EXECUTE_LINK" = "true" ]; then
  $LINK_CMD
else
  echo -e "\n\nExecute the commands to link dotfiles on this pc.\n\n"
  echo "$ $LINK_CMD"
fi

if [ "$DOTFILES_EXECUTE_SETUP" = "true" ]; then
  $SETUP_CMD
else
  echo -e "\n\nExecute the commands to setup this pc.\n\n"
  echo "$ $SETUP_CMD"
fi


