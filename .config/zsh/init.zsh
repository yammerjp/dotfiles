# # please load this file from ~/.zshr
# if [ -e ~/.config/zsh/init.zsh ]; then
#   source ~/.config/zsh/init.zsh
# fi

zstyle ':completion:*' rehash true
autoload -Uz compaudit
autoload -Uz compinit
compinit -C

function main () {
  ZSH_SCRIPT_PATHS=( \
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

function os_distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other 
    echo 'Ubuntu'
    return
  fi
}

OS="$(uname -s)"          # Darwin Linux
ARCH="$(uname -m)"        # arm64 x86_64
DIST="$(os_distribution)" # Ubuntu         # allow empty

ZSH_SCRIPT_FILENAMES=( \
  "variables.zsh" \
  "${(L)OS}-${(L)DIST}-${(L)ARCH}.zsh" \
  "${(L)OS}-${(L)DIST}.zsh" \
  "${(L)OS}.zsh" \
  "prompt.zsh" \
  "history.zsh" \
  "alias.zsh" \
  "git.zsh" \
  "homebrew.zsh" \
  "gitw.zsh" \
  "detect-to-edit-dotfiles.zsh" \
  "completion.zsh" \
)

for ELEMENT in $ZSH_SCRIPT_FILENAMES; do
  if [ -e "$HOME/.config/zsh/$ELEMENT" ]; then
    source "$HOME/.config/zsh/$ELEMENT"
  fi
done

# # 計測
# # for i in $(seq 1 10); do time zsh -i -c exit; done
# # zmodload zsh/zprof && zprof
# 
# # 計測
# if (which zprof > /dev/null 2>&1) ;then
#   zprof | less
# fi
