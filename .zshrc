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

if ! command -v sheldon > /dev/null ; then
  if [ "$(uname)" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
    curl -o ~/.local/bin/sheldon https://blob.yammer.jp/bin/sheldon-darwin-arm64-0.7.1
    chmod u+x ~/.local/bin/sheldon
  else
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
      | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
  fi
fi

eval "$(sheldon source)"

autoload -U compinit
compinit

# zsh initial time measurement
if (which zprof > /dev/null) ;then
  zprof | cat
fi

alias ztime="time (ZSH_TIME=true zsh -i -c exit)"

if (which rtx > /dev/null); then
  eval "$(rtx activate zsh)"
fi
