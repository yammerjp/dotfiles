# This file is applications' settings such as adding $PATH

# 計測
# for i in $(seq 1 10); do time zsh -i -c exit; done
# zmodload zsh/zprof && zprof

source "$HOME/.zshrc-darwin-arm64"
source "$HOME/.zshrc-darwin"
source "$HOME/.zshrc-common"
if [ -e "$HOME/.zshrc-private" ]; then
  source "$HOME/.zshrc-private"
fi

# 計測
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi

export PATH="$HOME/go/bin:$PATH"
