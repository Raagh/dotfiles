#!/bin/bash
# Resets tmux input state to prevent stuck keys
tmux list-panes -s -F "#{session_name}:#{window_index}.#{pane_index}" |
	xargs -I {} tmux select-pane -t {} -e
