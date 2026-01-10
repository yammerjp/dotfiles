alias k=kubectl
alias du='du -h'
alias vi='vim -u NONE'
alias vim='nvim'
alias tree='tree -N'
alias ssh='ssh -A'
alias eucjp2utf8="iconv -f EUC-JP -t UTF-8"
alias y='yadm'
alias yadm-private="YADM_REPO=$HOME/.local/share/yadm/repo-private.git yadm --yadm-repo $HOME/.local/share/yadm/repo-private.git"
alias nv='nvim'

# colordiff
if [[ -x `which colordiff 2> /dev/null` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-R'

# man
function man() {
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

function mknow() {
  mkdir -p "$HOME/tmp/$(date '+%Y%m%d')-$(date | sha1sum | awk '{print substr($0, 0, 4)}')"
    cd $_
}
