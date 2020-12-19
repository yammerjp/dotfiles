#=================================補完====================================
# キーバインドをviにする
bindkey -v

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの表示間隔を狭くする
setopt list_packed

#=================================man====================================
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;36m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}
# [manの読み方（初心者向け） - Qiita](https://qiita.com/aosho235/items/0f2b73d08eb645c05208)
# [manコマンドで表示されるドキュメントの色付けをカスタマイズ - Steel Dragon 14106](https://raimon49.github.io/2017/03/31/man-with-colored-pager.html)

#=================================history====================================
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

alias his="history -i -t '%Y/%m/%d-%H:%M'"
alias his-all="history -t '%Y/%m/%d-%H:%M' -E 1"
alias hisall="his-all"
hispeco () {
  if [ ${OSTYPE} = 'darwin' ]; then
    cmd=$(his-all | tail -r | peco | awk '{c="";for(i=3;i<=NF;i++) c=c $i" "; print c}')
  else
    cmd=$(his-all | tac | peco | awk '{c="";for(i=3;i<=NF;i++) c=c $i" "; print c}')
  fi
  BUFFER="$cmd"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N hispeco
bindkey '^h' hispeco


#=================================表示====================================
# 左プロンプト
PROMPT='%F{yellow}$ '
# [user@host] dir $
# PROMPT='[%n@%m] %~ $ '

# 右プロンプト
# %F{〜}は色指定、%fでリセット
# %nはログインユーザ名、%~はカレントディレクトリ
# "%(?..%F{red}-%?-)" は終了コードが0以外なら赤色で表示
# "%1(v|%F{yellow}%1v%F{green} |)" の部分がVCS情報 (psvarの長さが1以上なら黄色で表示)
RPROMPT="%(?..%F{red}-%?-)%F{green}[%1(v|%F{yellow}%1v%F{green} |)%n:%~ %T]%f"

# コマンド実行後に非表示 (つまり最終行のみ表示される)
setopt transient_rprompt

# gitブランチ名表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%c%u%b'
zstyle ':vcs_info:git:*' actionformats '%c%u%b|%a'

# カレントディレクトリ/コマンド記録
local _cmd=''
local _lastdir=''
preexec() {
  _cmd="$1"
  _lastdir="$PWD"
  echo -ne "\e[0m" # プロンプトの色を元に戻す
}
# git情報更新
update_vcs_info() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# カレントディレクトリ変更時/git関連コマンド実行時に情報更新
precmd() {
  _r=$?
  case "${_cmd}" in
    git*|stg*) update_vcs_info ;;
    *) [ "${_lastdir}" != "$PWD" ] && update_vcs_info ;;
  esac
  return $_r
}


#=================================OS別の設定====================================
case ${OSTYPE} in
  darwin*) #Mac用の設定
    export CLICOLOR=1
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    ;;
  linux*) #Linux用の設定
    # yarnをpathに設定
    export PATH="$PATH:$(yarn global bin)"
    # visudoをviに設定
    export EDITOR="/bin/vi"
    export SUDO_EDITOR="/bin/vi"
    # deno
    if [ -e "$HOME/.deno" ]; then
      export DENO_INSTALL="$HOME/.deno"
      export PATH="$DENO_INSTALL/bin:$PATH"
    fi
    ;;
esac
