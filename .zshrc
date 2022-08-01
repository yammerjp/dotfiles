### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light olets/zsh-abbr

### End of Zinit's installer chunk

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
