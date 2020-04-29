#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi

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

