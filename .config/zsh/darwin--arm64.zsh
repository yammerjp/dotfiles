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
  abbr -S cr='cargo run'
fi

if [ -e "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi
