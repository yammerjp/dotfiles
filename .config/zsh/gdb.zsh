if command -v gdb > /dev/null; then
	export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history
  gdb --nh -x "$XDG_CONFIG_HOME"/gdb/init
fi
