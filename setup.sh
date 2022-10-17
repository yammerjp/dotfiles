#!/bin/bash -e
# for GitHub codespaces

SCRIPT_DIR=$(dirname "$0")
DOTFILE_DIRS="$SCRIPT_DIR" "${SCRIPT_DIR}/.local/bin/dotfiles" link
DOTFILE_DIRS="$SCRIPT_DIR" "${SCRIPT_DIR}/.local/bin/dotfiles" setup
