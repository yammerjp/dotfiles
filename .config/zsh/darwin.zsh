
export CLICOLOR=1

alias cpy="pbcopy"
alias pst="pbpaste"
alias tac="tail -r"
#alias sha256sum="shasum -a 256"
alias ls='ls -FGh' # "-F":ディレクトリに"/"を表示, "-G"でディレクトリを色表示, "-h":ファイルサイズを人間が読みやすい形式に
# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'

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

alias nv='nvim'
alias purevim='/usr/bin/vim'
alias vim='nvim'

# use gnu dircolors
if [ -x `whence -p gdircolors` ]; then alias dircolors='gdircolors'; fi
eval `dircolors --sh ~/.gruvbox.dircolors`

# enable ls colors for zsh completion
if [ -x `whence -p gls` ]; then alias ls='gls --color=auto'; fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
