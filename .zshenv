if [ "$ZSH_TIME" = "true" ]; then
  zmodload zsh/zprof && zprof
  # https://ktrysmt.github.io/blog/lt-about-code-review/
fi

if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

if [ -e "$HOME/.config/zsh/variables.zsh" ]; then
  source $HOME/.config/zsh/variables.zsh
fi

if [ -e "$HOME/.config/zsh/asdf.zsh" ]; then
  source $HOME/.config/zsh/asdf.zsh
fi
