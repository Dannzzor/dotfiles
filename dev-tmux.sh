#!/bin/sh
tmux new -s 'dev' -d 'nvim'
tmux split-window -v -p 20 
tmux split-window -h -p 60
tmux split-window -h -p 30
tmux a -t 'dev'
