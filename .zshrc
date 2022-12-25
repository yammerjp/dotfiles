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

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# zsh initial time measurement
if (which zprof > /dev/null) ;then
  zprof | cat
fi

alias ztime="time (ZSH_TIME=true zsh -i -c exit)"
