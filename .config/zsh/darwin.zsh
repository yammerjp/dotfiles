export CLICOLOR=1

alias cpy="pbcopy"
alias pst="pbpaste"
alias tac="tail -r"
#alias sha256sum="shasum -a 256"
# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'

# use gnu dircolors
if [ -x `whence -p gdircolors` ]; then
  alias dircolors='gdircolors'
fi
eval `dircolors --sh ~/.gruvbox.dircolors`

# enable ls colors for zsh completion
if [ -x `whence -p gls` ]; then
  alias ls='gls --color=auto'
else
  # "-F":ディレクトリに"/"を表示, "-G"でディレクトリを色表示, "-h":ファイルサイズを人間が読みやすい形式に
  alias ls='ls -FGh'
fi

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
