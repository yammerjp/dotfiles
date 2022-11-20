# visudoをviに設定
export EDITOR="/bin/vi"
export SUDO_EDITOR="/bin/vi"

alias vim="nvim"

if [ -x `whence -p xclip` ]; then
  alias cpy="xclip -selection clipboard"
  alias pst="xclip -selection clipboard -o"
fi

if [ -x `whence -p xdg-open` ]; then
  alias open='xdg-open'
fi

alias ls='ls -Fh --color=auto'

LC_CTYPE=ja_JP.UTF-8

if [ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval `dircolors --sh ~/.gruvbox.dircolors`
if [ -x `whence -p ls` ]; then alias ls='ls --color=auto'; fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
