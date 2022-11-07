# homebrew for arm64, darwin

# homebrew
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
# x86_64版のbrewを実行するとき, =brew で実行させる
setopt magic_equal_subst

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  alias cr='cargo run'
fi

if [ -e "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi
