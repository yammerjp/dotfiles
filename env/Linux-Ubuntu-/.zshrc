alias cpy="xclip -selection clipboard"
alias pst="xclip -selection clipboard -o"
alias ls='ls -Fh --color=auto'
alias open='xdg-open'

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  alias cr='cargo run'
fi

source "$HOME/.zshrc-common"
