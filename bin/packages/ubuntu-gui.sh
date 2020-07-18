#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! command -v apt > /dev/null 2>&1 ; then
  echo "Need apt"
  exit 1
fi

echo "Install packages for GUI"

# ========== HackGen ==========
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
bash "$SCRIPT_DIR/hackgen.sh"

# ========== xkeysnail ==========
apt install -y python3-pip
pip3 install xkeysnail

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
