# ~/.git-prompt.sh を読み込んで、__git_ps1コマンドを利用できるようにする
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  # プロンプト表示前に、ブランチ名をPS1に代入する
  PROMPT_COMMAND='__git_ps1 "[\u@\h \t \w" "]\\\$ "'
fi
. "$HOME/.cargo/env"
