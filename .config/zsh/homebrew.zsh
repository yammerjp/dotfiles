if ! command -v brew > /dev/null; then
  return
fi

BREWFILE="$XDG_CONFIG_HOME/homebrew/Brewfile.$(hostname)"
function brew-dump() {
  BREWFILE_TMP="/tmp/.Brewfile"
  rm -rf "$BREWFILE_TMP"
  brew bundle dump --file "$BREWFILE_TMP"
  mkdir -p "$(dirname "$BREWFILE")"
  cat "$BREWFILE_TMP" > "$BREWFILE"
}

function brew-bundle() {
  brew bundle --file "$BREWFILE"
}

brew() {
  sub_command="$1"
  command brew $@
  if [ "$sub_command" = "install" ] || [ "$sub_command" = "uninstall" ]; then
    brew-dump
  fi
}
