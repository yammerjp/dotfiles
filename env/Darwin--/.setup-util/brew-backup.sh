#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

brew bundle dump --file Brewfile

