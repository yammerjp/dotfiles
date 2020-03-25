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
# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示 "-h":ファイルサイズを人間が読みやすい形式に
alias ls='ls -FGh'
# alias ll='ls -alFG'

# git alias
alias g='git'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"


#=================================macOS====================================
# MacのGUIアプリケーションを実行
alias prev='open /Applications/Preview.app'
alias xcode='open /Applications/Xcode.app'
