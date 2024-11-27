#!/bin/bash

# Start a new tmux session with the first window named "Root"
tmux new-session -d -n "X"

# Create 6 more windows in the tmux session
for i in {2..7}; do
	tmux new-window

	# Start Fish shell in each new window
	# tmux send-keys -t "$i" "fish" Enter

	# sleep 0.5
done

# Change directory to "Downloads" in every 4th window (starting from Window_4)
for i in {4..7}; do
	if [ $((i % 4)) -eq 0 ]; then
		tmux send-keys -t "$i" "cd ~/Downloads" Enter
	fi
done

# Attach to the tmux session
tmux attach-session
