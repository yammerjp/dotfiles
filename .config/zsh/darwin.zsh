export CLICOLOR=1

alias cpy="pbcopy"
alias pst="pbpaste"
alias tac="tail -r"
#alias sha256sum="shasum -a 256"
# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
