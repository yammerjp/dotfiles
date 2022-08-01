abbr -S cpy="xclip -selection clipboard"
abbr -S pst="xclip -selection clipboard -o"
abbr -S ls='ls -Fh --color=auto'
abbr -S open='xdg-open'

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  abbr -S cr='cargo run'
fi

if [ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

nodenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(nodenv init -)
  $0 "$@"
}
