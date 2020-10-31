#!/bin/bash
tmux split-window -d -t 0
tmux send-keys -t 0 vim C-m
tmux split-window -h -t 1
tmux select-pane -t 0
tmux resize-pane -t 0 -D 10
tmux send-keys -t 0 ':e ~/dev/'
