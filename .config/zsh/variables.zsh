export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# (N-/) ... ディレクトリが存在するときのみ追加
path=(
  $HOME/bin(N-/)
  $HOME/.bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.config/npm-packages/bin(N-/)
  $HOME/go/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.composer/vendor/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  /opt/homebrew/opt/luajit-openresty/bin(N-/)
  $path
)
