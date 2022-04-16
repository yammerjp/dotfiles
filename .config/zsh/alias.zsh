alias du='du -h'
alias vi='vim -u NONE'
alias tree='tree -N'
alias search='find . -type f | grep -v "/.git/" | xargs grep'
alias covid19='curl https://corona-stats.online/'
alias ssh='ssh -A'
alias ipe='curl ipinfo.io/ip'
alias bip='bundle install --path vendor/bundle'
alias eucjp2utf8="iconv -f EUC-JP -t UTF-8"

# ssh
function ssh-authorized_keys-refresh() {
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  if [ -e ~/.ssh/authorized_keys.org ]; then
    echo "Please evacuate ~/.ssh/authorized_keys.org"
    return
  fi
  if [ -e ~/.ssh/authorized_keys ]; then
    mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.org
  fi
  curl https://github.com/yammerjp.keys > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
}
function ssh-keygen-me() {
  ssh-keygen -t rsa -b 4096 -C "me@yammer.jp"
}

# colordiff
if [[ -x `which colordiff 2> /dev/null` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-R'

# memo
function memo() {
  memo_repo_dir="$HOME/src/github.com/yammerjp/memo"
  if ! [ -e $memo_repo_dir ]; then
    gclone memo
  fi
  dairy_dir="$memo_repo_dir/daylog"
  mkdir -p ${dairy_dir}
  vim "${dairy_dir}/$(date '+%Y%m%d').md"
}

# compress
function compress() {
  if ! [ -n "$1" ]; then
    echo "Usage: $0 <compressing-dir>" 1>&2
    return
  fi
  echo "tar -zcvf $1.tar.gz $1"
  tar zcvf "$1.tar.gz" "$1"
}
function decompress() {
  if ! [ -n "$1" ]; then
    echo "Usage: $0 <decompressing-file.tar.gz>" 1>&2
    return
  fi
  if ! [[ "$1" =~ "\.tar\/.gz$" ]]; then
    echo "Usage: $0 <decompressing-file.tar.gz>" 1>&2
    return
  fi
  echo "tar zxvf $1"
  tar -zxvf "$1"
}

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

# vscode
VSCODE_EXTENSION_LIST="$XDG_CONFIG_HOME/vscode/extension-list"
function vscode-extensions-export () {
  code --list-extensions > "$VSCODE_EXTENSION_LIST"
}
function vscode-extensions-import () {
  if ! [ -e "$VSCODE_EXTENSION_LIST" ]; then
    echo "$VSCODE_EXTENSION_LIST is not found..." 1>&2
    return
  fi
  cat "$VSCODE_EXTENSION_LIST" | while read extension; do
    code --install-extension $extension
  done
}

# npm
NPM_PACKAGE_LIST="${XDG_CONFIG_HOME}/npm/package-list"
function npm-global-dump() {
  npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' > "$NPM_PACKAGE_LIST"
}

function npm-global-bundle() {
  while read pkg
  do
    npm install --global $pkg
  done < "$NPM_PACKAGE_LIST"
}

function nodenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(nodenv init -)
  $0 "$@"
}

function rbenv() {
  # コマンド実行時に遅延読み込み
  # https://qiita.com/Suzuki09/items/6c27a8a875cf94d981a4
  unfunction "$0"
  source <(rbenv init -)
  $0 "$@"
}

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
