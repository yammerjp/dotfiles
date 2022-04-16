#!/bin/bash -e

# download ... dotfiles/bin/download.sh
# link     ... make link

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

# os initializing setup
bash "$HOME/.config/yammerjp/darwin-userdefaults.sh"

# package install
ARCH="$(uname -m)" # arm64 or x86_64
brew bundle --file "$HOME/.config/homebrew/package-list-darwin-${ARCH}"

eval "rbenv init -"
latest_stable_ruby="$(rbenv install -l 2>/dev/null | grep -e '^[0-9. ]\+$' | tail -1)"

rbenv install "$latest_stable_ruby"
rbenv global "$latest_stable_ruby"

eval "nodenv init -"
latest_stable_node="$(nodenv install -l 2>/dev/null | grep -e '^[0-9. ]\+$' | tail -1)"
nodenv install "$latest_stable_node"
nodenv global "$latest_stable_node"

eval "pyenv init -"
latest_stable_python="$(pyenv install -l 2>/dev/null | grep -e '^[0-9. ]\+$' | tail -1)"
pyenv install "$latest_stable_python"
pyenv global "$latest_stable_python"

# vim init
vim -s .vimop

echo "Nothing to do" 1>&2
