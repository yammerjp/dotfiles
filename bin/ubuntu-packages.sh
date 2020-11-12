#!/bin/bash -e
# ======================================== Function Definition ========================================
Install_nodejs () {
  curl -sL https://deb.nodesource.com/setup
  apt update
  apt upgrade -y
  apt install -y nodejs
}

Install_git () {
  add-apt-repository -y ppa:git-core/ppa
  apt install -y git
}

Install_yarn () {
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
  YARN_PACKAGE_URL='deb https://dl.yarnpkg.com/debian/ stable main'
  YARN_LIST='/etc/apt/sources.list.d/yarn.list'
  if ! grep -q "$YARN_PACKAGE_URL" "$YARN_LIST" ; then
    echo "$YARN_PACKAGE_URL" >> "$YARN_LIST"
  fi
  apt update
  apt install -y yarn
}

Install_deno () {
  # shellcheck disable=SC2153
  sudo_user="$SUDO_USER"
  curl -fsSL https://deno.land/x/install/install.sh | sudo su - "$sudo_user"
  sudo_user_home=$(getent passwd "$sudo_user")
  "$sudo_user_home"/.deno/bin/deno completions zsh >  /usr/local/share/zsh/site-functions/_deno
}

Install_hackgen () {
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
}

Install_vscode () {
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
  sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  apt install -y apt-transport-https
  apt update
  apt install -y code # or code-insiders
  # https://wiki.debian.org/VisualStudioCode
  # https://code.visualstudio.com/docs/setup/linux
}

Install_spotify () {
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | apt-key add -
  SPOTIFY_PACKAGE_URL="deb http://repository.spotify.com stable non-free"
  SPOTIFY_LIST="/etc/apt/sources.list.d/spotify.list"
  if ! grep -q "$SPOTIFY_PACKAGE_URL" "$SPOTIFY_LIST" ; then
    echo "$SPOTIFY_PACKAGE_URL" >> "$SPOTIFY_LIST"
  fi
  apt update
  apt install -y spotify-client
  # https://www.spotify.com/jp/download/linux/
}

Install_vivaldi () {
  wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | apt-key add -
  add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
  apt update
  apt install -y vivaldi-stable
  #  https://help.vivaldi.com/ja/article/manual-setup-vivaldi-linux-repositories/
}

# ======================================== Package Installation ========================================

echo "Install packages"

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! command -v apt > /dev/null 2>&1 ; then
  echo "Need apt"
  exit 1
fi

echo "Install packages for minimum"

apt install -y curl
Install_nodejs
Install_git
Install_yarn
Install_deno
apt install -y vim
apt install -y zsh
apt install -y tmux
apt install -y colordiff
apt install -y gdebi
apt install -y nkf
apt install -y nmap
apt install -y shellcheck
apt install -y tree
apt install -y openssh-server # sudo systemctl enable ssh
snap install docker

if [ "$1" = "minimum" ]; then
  echo "Finished minimum packages"
  exit 0
fi

echo "Install another packages"

Install_hackgen
Install_vscode
Install_spotify
Install_vivaldi
apt install -y ibus-mozc
apt install -y gimp
snap install chromium

if [ "$1" != "full" ]; then
  echo "Finished packages"
  exit 0
fi

echo "Install extra packages"
apt install -y screenruler
apt install -y ffmpeg
apt install -y imagemagick
snap install --classic heroku
snap install pick-colour-picker
snap install losslesscut
snap install obs-studio
snap install inkscape
snap install --classic shotcut
echo "Please install slack from deb package downloaded by web-browser !!" # snap install --classic slack
echo "Finished full packages"
