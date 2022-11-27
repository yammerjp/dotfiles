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
function rprompt_open {
  RPROMPT="%(?..%F{red}-%?-)%F{green}[%1(v|%F{yellow}%1v%F{green} |)%n@%m:%~ ]%f"
}
function rprompt_close {
  RPROMPT=""
}
rprompt_open

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
    g*|stg*) update_vcs_info ;;
    *) [ "${_lastdir}" != "$PWD" ] && update_vcs_info ;;
  esac
  return $_r
}

# '#' 以降をコメントとして扱う
setopt interactive_comments
