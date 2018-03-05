#!/bin/sh
tmux new -s 'hack' -d 'vim' 
tmux split-window -v -p 10
tmux split-window -h -p 30 -d 'htop'
tmux a -t 'hack'

