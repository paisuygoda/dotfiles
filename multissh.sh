#!/bin/bash

if [ -n "$SESSION_NAME" ];then
  session=$SESSION_NAME
else
  session=multi-ssh-`date +%s`
fi
window=multi-ssh

## create new tmux session
tmux new-session -d -n $window -s $session

## ssh login at each host
## just ssh at first host
tmux send-keys "ssh ${hosts[0]}" C-m
hosts=("${hosts[@]:1}")

## ssh after creating pane
for i in ${hosts[@]};do
  tmux split-window
  tmux select-layout tiled
  tmux send-keys "ssh $i" C-m
done

## select first pane
tmux select-pane -t 0

## start synchronization of pane
tmux set-window-option synchronize-panes on

## attch to session
tmux attach-session -t $session