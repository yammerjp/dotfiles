alias n-exec=$(bash -c "which n")
alias n="echo \"Please type the command 'n-exec' if you want to execute 'n' that is nodejs version management tool.\""
alias du='du -h'
alias vi='vim -u NONE'
alias tree='tree -N'
alias search='find . -type f | grep -v "/.git/" | xargs grep'
alias covid19='curl https://corona-stats.online/'

alias ide="bash ~/.tmux-ide.sh"

# git
alias g='git'
alias gs='g s'
alias gS='g s'
alias ga.='g a .'
gclone() {
  if [ -z "$1" ]; then
    echo 'Usage: gclone username reponame # clone git repository from github.com'
    return 1
  fi
  if [ -z "$2" ]; then
    repo="basd4g/$1"
  else
    repo="$1/$2"
  fi
  clone_to="$HOME/dev/github.com/${repo}"
  clone_from="git@github.com:${repo}.git"
  if ! git clone "${clone_from}" "${clone_to}"; then
    echo "Failed to clone from '${clone_from}' to '${clone_to}'"
    return 1
  fi
  cd "${clone_to}"
  echo "Cloned from '${clone_from}' to '${clone_to}', and moved there"
}

# ssh
ssh-authorized_keys-refresh() {
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  if [ -e ~/.ssh/authorized_keys ]; then
    mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.org
  fi
  curl https://github.com/basd4g.keys > ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
}

# colordiff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
export LESS='-R'

# memo
memo() {
  dairy_dir="$HOME/dev/github.com/basd4g/memo/daylog"
  mkdir -p ${dairy_dir}
  vim "${dairy_dir}/$(date '+%Y%m%d').md"
}

compress() {
  echo "tar zcvf $1.tar.gz $1"
  tar zcvf "$1.tar.gz" "$1"
}
decompress() {
  echo "tar zxvf $1"
  tar zxvf "$1"
}

zshcolors () {
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

case ${OSTYPE} in
  darwin*) #Mac用の設定
    alias cpy="pbcopy"
    alias pst="pbpaste"
    alias tac="tail -r"
    alias ls='ls -FGh' # "-F":ディレクトリに"/"を表示, "-G"でディレクトリを色表示, "-h":ファイルサイズを人間が読みやすい形式に
    # MacのGUIアプリケーションを実行
    alias prev='open /Applications/Preview.app'
    alias xcode='open /Applications/Xcode.app'
   ;;
  linux*) #Linux用の設定
    alias cpy="xclip -selection clipboard"
    alias pst="xclip -selection clipboard -o"
    alias ls='ls -Fh --color=auto'
    alias xm='xmodmap ~/.Xmodmap'
    alias open='xdg-open'
    ;;
esac

_SNIP_FILE="$HOME/.snip"
snipadd () {
  echo $@ >> $_SNIP_FILE
}
snippeco () {
  print -z $(cat $_SNIP_FILE | peco)
}
snipedit () {
  vim $_SNIP_FILE
}
# mmv
