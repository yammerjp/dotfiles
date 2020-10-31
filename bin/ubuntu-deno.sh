#!/bin/bash -e

if [ "$(uname)" != "Linux" ];then
  echo "The script to install deno allow to run by linux only"
  exit 1
fi

if [ "$(whoami)" = "root" ]; then
  echo "Require to run with unroot"
  exit 1
fi

curl -fsSL https://deno.land/x/install/install.sh | sh

echo -e "\n\nPlease excute the following command with sudo to completions!!"
echo "$ $HOME/.deno/bin/deno completions zsh | sudo tee /usr/local/share/zsh/site-functions/_deno > /dev/null"
