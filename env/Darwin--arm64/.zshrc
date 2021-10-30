# This file is applications' settings such as adding $PATH

# homebrew for arm64, darwin
# (N-/) ... ディレクトリが存在するときのみ追加
path=(
  /opt/homebrew/bin(N-/)
  /usr/local/bin(N-/)
  $path
)

# homebrew
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
if [ -e "/opt/homebrew/opt/luajit-openresty/bin" ]; then
  export PATH="/opt/homebrew/opt/luajit-openresty/bin:$PATH"
fi
if [ -e "/opt/homebrew/sbin" ]; then
  export PATH="/opt/homebrew/sbin:$PATH"
fi
# x86_64版のbrewを実行するとき, =brew で実行させる
setopt magic_equal_subst


# for nvm (nodejs version manager)
if [ -e /opt/local/share/nvm/init-nvm.sh ]; then
  source /opt/local/share/nvm/init-nvm.sh
fi

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  alias cr='cargo run'
fi



# Macports
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export DISPLAY=:0

source "$HOME/.zshrc-darwin"
source "$HOME/.zshrc-common"
