SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

# os initializing setup
bash "$HOME/.config/yammerjp/darwin-userdefaults.sh"

BREWFILE="$XDG_CONFIG_HOME/homebrew/Brewfile.$(hostname)"
if [ -e "$BREWFILE" ]; then
  brew bundle --file "$BREWFILE"
else
  printf "Brewfile is not found ...\n%s\n" "$BREWFILE" 1>&2
fi

echo "Nothing to do" 1>&2
