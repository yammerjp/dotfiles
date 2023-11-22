alias du='du -h'
alias vi='vim -u NONE'
alias tree='tree -N'
alias search='find . -type f | grep -v "/.git/" | xargs grep'
alias covid19='curl https://corona-stats.online/'
alias ssh='ssh -A'
alias ipe='curl ipinfo.io/ip'
alias bip='bundle install --path vendor/bundle'
alias eucjp2utf8="iconv -f EUC-JP -t UTF-8"
alias vim-config-edit="vim $XDG_CONFIG_HOME/nvim/init.vim"
alias vim-origin="/usr/bin/vim"
alias dc="docker compose"
alias snip="vim ~/src/github.com/yammerjp/memo/snippets.md"
alias y='yadm'
alias yadm-private="YADM_REPO=$HOME/.local/share/yadm/repo-private.git yadm --yadm-repo $HOME/.local/share/yadm/repo-private.git"
alias .z="vim ~/.config/zsh/*"
alias .g="vim ~/.config/git/*"
alias .v="vim $XDG_CONFIG_HOME/nvim/init.vim"
alias .t="vim ~/.tmux.conf"
alias a1="awk '{ print \$1 }'"
alias a2="awk '{ print \$2 }'"
alias a3="awk '{ print \$3 }'"
alias a4="awk '{ print \$4 }'"
alias a5="awk '{ print \$5 }'"
alias purevim='/usr/bin/vim'
alias nv='nvim'
alias lsof-3306="lsof -i:3306"
alias ssh-boot='eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa'

# colordiff
if [[ -x `which colordiff 2> /dev/null` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-R'

# color
function zshcolors () {
  for num in `seq 256`;do
    echo -ne "\e[38;5;${num}m${num}\t\e[0m"
    if [ `expr $num "%" 16` = 0 ];then
      echo
    fi
  done
  for num in `seq 256`;do
    echo -ne "\e[48;5;${num}m${num}\t\e[0m"
    row=`expr $num "%" 16`
    if [ `expr $num "%" 16` = 0 ];then
      echo
    fi
  done
}

# mmv

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

function cpnew() {
  cp ~/.config/yammerjp/competitive-programming-template.cpp ./$1
  vim $1
}

function hgrep() {
    command hgrep --term-width "$COLUMNS" "$@" | less -R
}

function svim() {
    tmux has-session &> /dev/null
    if [ $? = 0 ] && [ $COLUMNS -ge 120 ];
    then
        tmux split-window -h -p 70 "vim $1"
    else
        vim $1
    fi
}

function mknow() {
    mkdir -p "$HOME/tmp/$(date '+%Y-%m-%dT%H:%M:%S%z')"
    cd $_
}

function random() {
  date | sha1sum | awk '{ print $1 }' | tee /dev/stderr | cpy
}
