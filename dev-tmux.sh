#!/bin/sh
tmux new -s 'dev' -d
tmux split-window -v -p 10
tmux split-window -h -p 60
tmux split-window -h -p 30
tmux a -t 'dev'
