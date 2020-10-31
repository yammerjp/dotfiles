#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! command -v apt > /dev/null 2>&1 ; then
  echo "Need apt"
  exit 1
fi

echo "Install packages for CUI"

# ========== nodejs ==========
curl -sL https://deb.nodesource.com/setup
apt update
apt upgrade -y
apt install -y nodejs

# ========== git =========
add-apt-repository -y ppa:git-core/ppa
apt install -y git

# ========= yarn =========
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update
apt install -y yarn

# ========== apt ==========
apt install -y vim
apt install -y zsh
apt install -y curl
apt install -y tmux

apt install -y colordiff
apt install -y gdebi
apt install -y ffmpeg
apt install -y nkf
apt install -y nmap
apt install -y shellcheck
apt install -y tree
apt install -y imagemagick

# ========== snap ==========
snap install --classic heroku
snap install docker
