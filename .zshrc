#=================================git補完====================================
# $ ls -l `brew --prefix`/share/zsh/site-functions/
# で_gitとgit-completion.bashが表示されていることを確認
# されていない場合は
# $ brew link git
# または
# $ brew link --overwrite git
# を行う
# 参考: https://gist.github.com/d-kuro/352498c993c51831b25963be62074afa

# brewでインストールしたときのgit補完
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)


#=================================補完====================================
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


#=================================alias====================================

# git alias
alias g='git'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"


#=================================表示====================================

PROMPT='$ '
# [user@host] dir $
# PROMPT='[%n@%m] %~ $ '

#右プロンプト
# %F{〜}は色指定、%fでリセット
# %nはログインユーザ名、%~はカレントディレクトリ
# "%(?..%F{red}-%?-)" は終了コードが0以外なら赤色で表示
# "%1(v|%F{yellow}%1v%F{green} |)" の部分がVCS情報 (psvarの長さが1以上なら黄色で表示)
RPROMPT="%(?..%F{red}-%?-)%F{green}[%1(v|%F{yellow}%1v%F{green} |)%n:%~ %T]%f"

# コマンド実行後に非表示 (つまり最終行のみ表示される)
setopt transient_rprompt

#gitブランチ名表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%c%u%b'
zstyle ':vcs_info:git:*' actionformats '%c%u%b|%a'

#カレントディレクトリ/コマンド記録
local _cmd=''
local _lastdir=''
preexec() {
  _cmd="$1"
  _lastdir="$PWD"
}
#git情報更新
update_vcs_info() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
#カレントディレクトリ変更時/git関連コマンド実行時に情報更新
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
    # "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示 "-h":ファイルサイズを人間が読みやすい形式に
    alias ls='ls -FGh'
    # MacのGUIアプリケーションを実行
    alias prev='open /Applications/Preview.app'
    alias xcode='open /Applications/Xcode.app'
    ;;

  linux*) #Linux用の設定
    alias ls='ls -Fh --color=auto'
    ;;
esac
