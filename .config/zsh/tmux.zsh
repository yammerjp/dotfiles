function update_tmux_window_name() {
  if [[ -n "$TMUX" ]]; then
    local top_cmd=$(ps -o comm= -p "$$")

    if [[ "$top_cmd" == "-zsh" ]]; then
      local name="${PWD##*/}"
    else
      local name="$top_cmd"
    fi

    tmux rename-window "$name"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd update_tmux_window_name
update_tmux_window_name
