#!/bin/bash -e

function change_login_shell() {
  # Change login shell to zsh.
  if ! command -v zsh; then
    # shellcheck disable=SC2154
    echo "$password" | sudo -S apt install zsh -y
  fi
  username="$(whoami)"
  echo "$password" | sudo -S chsh --shell "$(command -v zsh)" "$username"
}

function rename_home_dirs() {
  #  ... ubuntu home dir
  # mv "~/ダウンロード" "~/Downloads"
  #                                   ... and so on ...
  if [ "$CI" != "true" ]; then
    LANG=C xdg-user-dirs-gtk-update
  fi
}

function install_packages() {
  # package install
  echo "$password" | sudo -S bash "$HOME/.config/yammerjp/setup-packages-linux-ubuntu.sh"
}

function install_nvim_plugins() {
  # nvim plugin install
  nvim -s "$HOME/.config/nvim/plugin-install-operation"
}





# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

# read -rsp password
# 
# change_login_shell
# 
# rename_home_dirs
# 
install_packages

install_nvim_plugins
