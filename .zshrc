zstyle ':completion:*' rehash true
autoload -Uz compaudit
autoload -Uz compinit
compinit -C

function main () {
  ZSH_SCRIPT_PATHS=( \
    $HOME/.config/zsh/init.zsh \
    $HOME/.zshrc.company \
    $HOME/.zshrc.private \
    $HOME/.zshrc.local \
  )
  for ZSH_SCRIPT_PATH in $ZSH_SCRIPT_PATHS; do
    if [ -e $ZSH_SCRIPT_PATH ]; then
      source "$ZSH_SCRIPT_PATH"
    fi
  done
}

main

# zsh initial time measurement
if (which zprof > /dev/null) ;then
  zprof | cat
fi

if (which mise > /dev/null); then
  alias rtx=mise
  eval "$(mise activate)"
fi

alias ztime="time (ZSH_TIME=true zsh -i -c exit)"

alias code=cursor
