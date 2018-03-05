#!/bin/sh
tmux new -s 'dev' -d 'vim'
tmux split-window -v -p 20 
tmux split-window -h -d 'htop'
tmux a -t 'dev'
