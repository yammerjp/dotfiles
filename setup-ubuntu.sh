#!/bin/bash

set -e

function apt_before() {
  # パッケージ更新時に出現する一部のダイアログ表示を抑制する
  echo -e "\$nrconf{kernelhints} = '0';\n\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/50-autorestart-tmp.conf
}

function apt_after() {
  sudo rm -f /etc/needrestart/conf.d/50-autorestart-tmp.conf
}

function change_login_shell() {
  # Change login shell to zsh.
  if ! command -v zsh; then
    apt_before
    sudo apt-get update -y
    sudo apt-get install -y  zsh
    apt_after
  fi
  username="$(whoami)"
  sudo chsh --shell "$(command -v zsh)" "$username"
}

function install_docker() {
  # ref: https://docs.docker.com/engine/install/ubuntu/
  apt_before
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release
  sudo mkdir -m 0755 -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo groupadd docker
  sudo usermod -aG docker "$USER"
  sudo chgrp docker /var/run/docker.sock
  sudo systemctl restart docker
  newgrp docker
  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service
  apt_after
}

function install_packages() {
  apt_before
  sudo apt-get update -y
  sudo apt-get install -y \
    curl \
    yadm \
    vim \
    neovim \
    zsh \
    tmux \
    colordiff \
    gdebi \
    nkf \
    nmap \
    shellcheck \
    tree \
    fzf
  apt_after
}

function install_nvim_plugins() {
  # nvim plugin install
  nvim -s "$HOME/.config/nvim/plugin-install.vim"
}

change_login_shell
install_packages
install_docker
install_nvim_plugins
