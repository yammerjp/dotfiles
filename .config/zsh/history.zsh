HISTSIZE=50000 # メモリに保存するコマンド数
HISTFILE=~/.zsh_history
SAVEHIST=100000 # ヒストリファイルに保存するコマンド数
setopt extended_history # historyファイルに時刻情報を記録

# 重複するコマンド行は古い方を削除
setopt hist_ignore_all_dups
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# コマンド履歴ファイルを共有する
setopt share_history
# 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt append_history
# 履歴をインクリメンタルに追加
setopt inc_append_history
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 空白で始まるコマンドは履歴に登録しない
setopt hist_ignore_space

alias his="history -i -t '%Y/%m/%d-%H:%M'"
alias his-all="history -t '%Y/%m/%d-%H:%M' -E 1"
alias hisall="his-all"

# shellのhistory一覧
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --height 50% --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^t' select-history

# shellのhistory一覧
function select-history-perfect-matching() {
  BUFFER=$(history -n -r 1 | fzf -e --no-sort +m --height 50% --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history-perfect-matching
bindkey '^r' select-history-perfect-matching
