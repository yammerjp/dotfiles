#!/bin/bash -e
TMP_HYPER="/tmp/dotfiles/hyper.deb"
curl -L https://releases.hyper.is/download/deb -o "$TMP_HYPER"
gdebi "$TMP_HYPER"

