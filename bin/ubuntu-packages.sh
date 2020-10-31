#!/bin/bash -e

echo "Install packages"

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

if [ "$1" = "minimum" ]; then
  exit 0
fi

echo "Install packages for GUI"


# ========== HackGen ==========
TMP_FILE="/tmp/dotfiles/hackgen"
TMP_FILE_ZIP="$TMP_FILE.zip"
TMP_DIR="$(dirname "$TMP_FILE_ZIP")"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

VERSION="$(curl -sI https://github.com/yuru7/HackGen/releases/latest | grep location | awk -F '/' '{print $NF }')"
# 改行削除
# shellcheck disable=SC2001
VERSION="${VERSION//[\r\n]\+/}"
URL="https://github.com/yuru7/HackGen/releases/download/$VERSION/HackGen_$VERSION.zip"

echo "Download HackGen font from $URL"
curl -fsSL "$URL" -o "$TMP_FILE_ZIP"
unzip "$TMP_FILE"
mv "HackGen_$VERSION" "/usr/share/fonts/HackGen"
fc-cache -fv


if [ "$1" = "minimum" ]; then
  echo "Finished minimum packages"
  exit 0
fi

apt install -y ibus-mozc
apt install -y gimp

# ========== snap ==========
snap install --classic code
snap install chromium
snap install --classic shotcut
snap install --classic slack
