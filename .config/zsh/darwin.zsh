
export CLICOLOR=1

abbr -S cpy="pbcopy"
abbr -S pst="pbpaste"
abbr -S tac="tail -r"
#abbr -S sha256sum="shasum -a 256"
abbr -S ls='ls -FGh' # "-F":ディレクトリに"/"を表示, "-G"でディレクトリを色表示, "-h":ファイルサイズを人間が読みやすい形式に
# MacのGUIアプリケーションを実行
abbr -S prev='open /Applications/Preview.app'
abbr -S xcode='open /Applications/Xcode.app'

function brew-dump() {
  rm -rf /tmp/.Brewfile
  brew bundle dump --file /tmp/.Brewfile
  cat /tmp/.Brewfile > ~/.Brewfile
}

function brew-bundle() {
  brew bundle --file ~/.Brewfile
}

brew() {
  sub_command="$1"
  command brew $@
  if [ "$sub_command" = "install" ] || [ "$sub_command" = "uninstall" ]; then
    brew-dump
  fi
}

pyenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(pyenv init -)
  $0 "$@"
}

nodenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(nodenv init -)
  $0 "$@"
}

rbenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(rbenv init -)
  $0 "$@"
}

abbr -S nv='nvim'
abbr -S purevim='/usr/bin/vim'
abbr -S vim='nvim'

# use gnu dircolors
if [ -x `whence -p gdircolors` ]; then abbr -S dircolors='gdircolors'; fi
eval `dircolors --sh ~/.gruvbox.dircolors`

# enable ls colors for zsh completion
if [ -x `whence -p gls` ]; then abbr -S ls='gls --color=auto'; fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
