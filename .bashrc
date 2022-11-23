#!/bin/bash

set -o vi

_replace_by_history() {
  local l
  l=$(HISTTIMEFORMAT='' history | awk '{ print $2}'  | fzf --query "$READLINE_LINE")
  READLINE_LINE="$l"
  READLINE_POINT=${#l}
}
bind -x '"\C-r": _replace_by_history'
