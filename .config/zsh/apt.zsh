if ! command -v apt-get > /dev/null; then
  return
fi

APTFILE="$XDG_CONFIG_HOME/apt/Aptfile.$(hostname)"
function apt-dump() {
  mkdir -p "$(dirname "$APTFILE")"
  dpkg -l | grep ii | awk '{print $2}' > "$APTFILE"
}

function apt-bundle() {
  sudo apt update
  cat "$APTFILE" | xargs sudo apt-get install -y
}

apt() {
  command apt $@
  apt-dump
}

apt-get() {
  command apt-get $@
  apt-dump
}
