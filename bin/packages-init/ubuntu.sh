#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! which apt > /dev/null 2>&1 ; then
  echo "Need apt"
  exit 1
fi

echo "Install packages"

# ========== nodejs ==========
curl -sL https://deb.nodesource.com/setup_13.x | bash -
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

if [ "$1" = "minimum" ]; then
  echo "Finished minimum packages"
  exit 0
fi

apt install -y gdebi
apt install -y ffmpeg
apt install -y lynx
apt install -y mysql-server
apt install -y mysql-client
apt install -y nkf
apt install -y nmap
apt install -y shellcheck
apt install -y tree
apt install -y ibus-mozc

# ========== xkeysnail ==========
apt install -y python3-pip
pip3 install xkeysnail

# ========== snap ==========
snap install --classic code
snap install --classic heroku
snap install chromium
snap install docker

# ========== HackGen ==========
TMP_FILE="/tmp/dotfiles/hackgen.zip"
mkdir -p "$(dirname "$TMP_FILE")"
VERSION="$(curl -sI https://github.com/yuru7/HackGen/releases/latest | grep location | awk -F '/' '{print $NF }')"
mkdir -p "$(dirname "$TMP_HYPER")"
curl "https://github.com/yuru7/HackGen/releases/download/$VERSION/HackGen_$VERSION.zip" -o "$TMP_FILE"
unzip "$TMP_FILE"
mv "HackGen_$VERSION" "/usr/share/fonts/HackGen"
fc-cache -fv

