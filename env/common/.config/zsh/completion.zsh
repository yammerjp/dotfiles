# キーバインドをviにする
bindkey -v

# 補完機能有効にする
autoload -U compinit
compinit -u

# 補完候補に色つける
autoload -U colors
colors
# export LSCOLORS=Gxfxcxdxbxegedabagacad
# export LS_COLORS='di=0;96:ln=0;33:so=0;95:pi=0;95:ex=0;92:bd=0;95:cd=0;95:fi=0:or=0;93:mi=0;93'
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
