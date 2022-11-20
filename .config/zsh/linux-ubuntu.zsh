alias ls='ls -Fh --color=auto'

LC_CTYPE=ja_JP.UTF-8

if [ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

