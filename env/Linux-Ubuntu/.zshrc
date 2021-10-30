alias cpy="xclip -selection clipboard"
alias pst="xclip -selection clipboard -o"
alias ls='ls -Fh --color=auto'
alias open='xdg-open'

# for Rust lang
if [ -e "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
  alias cr='cargo run'
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source "$HOME/.zshrc-linux"
source "$HOME/.zshrc-common"