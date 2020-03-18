# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示 "-h":ファイルサイズを人間が読みやすい形式に
alias ls='ls -FGh'
# alias ll='ls -alFG'

# git alias
alias g='git'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# alias d='git'でもgit補完を効かせる
__git_complete g __git_main

# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'
