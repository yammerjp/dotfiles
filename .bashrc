# eval "%(direnv hook bash)"
# default:cyan / root:red
if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示 "-h":ファイルサイズを人間が読みやすい形式に
alias ls='ls -FGh'
# alias ll='ls -alFG'

# lsコマンドの代替 exa "-F":ディレクトリに"/"を表示
# alias ls='exa -F'

# git補完
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# git alias
alias g='git'

# alias d='git'でもgit補完を効かせる
__git_complete g __git_main

# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'
