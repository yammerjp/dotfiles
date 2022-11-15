function main () {
  if [ -e ~/.config/zsh/init.zsh ]; then
    source ~/.config/zsh/init.zsh
  else
    echo "not found: ~/.config/zsh/init.zsh"
  fi

  if [ -e ~/.zshrc.company ]; then
    source ~/.zshrc.company
  fi


  if [ -e ~/.zshrc.private ]; then
    source ~/.zshrc.private
  fi

  if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
  fi
}

if [ "$LOADED_ZSHRC" != "true" ] || [ "$FORCE_LOAD_ZSHRC" = "true" ]; then
  main
fi

LOADED_ZSHRC="false"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
