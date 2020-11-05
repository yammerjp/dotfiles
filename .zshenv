alias gs=''
alias vi='vim -u NONE'
alias search='find . -type f | xargs grep'
alias covid19='curl https://corona-stats.online/'
alias his="history -i"
alias his-all="history -E 1"
alias ide="bash ~/.tmux-ide.sh"

# git
alias g='git'
gclone() {
  if [ -n "$1" ]; then
    git clone "git@github.com:$1/$2.git"
  else
    echo 'Usage: gclone username reponame # clone git repository from github.com'
  fi
}

# ssh
ssh-authorized_keys-refresh() {
  mkdir -p ~/.ssh
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

compress() {
  echo "tar zcvf $1.tar.gz $1"
  tar zcvf "$1.tar.gz" "$1"
}
decompress() {
  echo "tar zxvf $1"
  tar zxvf "$1"
}

case ${OSTYPE} in
  darwin*) #Mac用の設定
    alias cpy="pbcopy"
    alias pst="pbpaste"
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
