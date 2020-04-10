#!/bin/bash -e
TMP_FILE="/tmp/dotfiles/hyper.deb"
mkdir -p "$(dirname "$TMP_FILE")"
curl -L https://releases.hyper.is/download/deb -o "$TMP_FILE"
gdebi "$TMP_FILE"

