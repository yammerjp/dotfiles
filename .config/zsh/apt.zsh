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


sudo-apt() {
  command sudo apt $@
  apt-dump
}

sudo-apt-get() {
  command sudo apt-get $@
  apt-dump
}
