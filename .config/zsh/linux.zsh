# visudoをviに設定
export EDITOR="/bin/vi"
export SUDO_EDITOR="/bin/vi"

alias vim="nvim"

eval `dircolors --sh ~/.gruvbox.dircolors`
if [ -x `whence -p ls` ]; then alias ls='ls --color=auto'; fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
