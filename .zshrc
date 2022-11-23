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

if [ "$LOADED_ZSHRC" != "true" ] || [ "$FORCE_LOAD_ZSHRC" = "true" ]; then
  main
fi

LOADED_ZSHRC="false"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if (which zprof > /dev/null) ;then
  zprof | less
fi
