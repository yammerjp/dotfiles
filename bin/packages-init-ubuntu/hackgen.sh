#!/bin/bash -e

TMP_FILE="/tmp/dotfiles/hackgen.zip"
mkdir -p "$(dirname "$TMP_FILE")"

VERSION="$(curl -sI https://github.com/yuru7/HackGen/releases/latest | grep location | awk -F '/' '{print $NF }')"
mkdir -p "$(dirname "$TMP_HYPER")"
curl "https://github.com/yuru7/HackGen/releases/download/$VERSION/HackGen_$VERSION.zip" -o "$TMP_FILE"
unzip "$TMP_FILE"
mv "HackGen_$VERSION" "/usr/share/fonts/HackGen"
fc-cache -fv

