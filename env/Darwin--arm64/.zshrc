# This file is applications' settings such as adding $PATH

# 計測
# for i in $(seq 1 10); do time zsh -i -c exit; done
# zmodload zsh/zprof && zprof

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

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  alias cr='cargo run'
fi

source "$HOME/.zshrc-darwin"
source "$HOME/.zshrc-common"

# 計測
# zprof
