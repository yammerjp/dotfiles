#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! which apt > /dev/null 2>&1 ; then
  ech "Need apt"
  exit 1
fi

ech "Install packages"

# ========== nodejs ==========
curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt update
apt upgrade -y
apt install -y nodejs

# ========== git =========
add-apt-repository ppa:git-core/ppa
apt install -y git

# ========== apt ==========
apt install -y yarn
apt install -y vim
apt install -y zsh

if [ "$1" = "minimum" ]; then
  ech "Finished minimum packages"
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

# ========== docker ==========
curl https://get.docker.com | sh

# docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# ========== HackGen ==========
TMP_FILE="/tmp/dotfiles/hackgen.zip"
mkdir -p "$(dirname "$TMP_FILE")"
VERSION="$(curl -sI https://github.com/yuru7/HackGen/releases/latest | grep location | awk -F '/' '{print $NF }')"
mkdir -p "$(dirname "$TMP_HYPER")"
curl "https://github.com/yuru7/HackGen/releases/download/$VERSION/HackGen_$VERSION.zip" -o "$TMP_FILE"
unzip "$TMP_FILE"
mv "HackGen_$VERSION" "/usr/share/fonts/HackGen"
fc-cache -fv

