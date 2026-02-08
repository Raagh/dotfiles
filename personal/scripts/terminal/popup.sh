#!/bin/bash
# Toggleable popup terminal window
# Opens a popup at 80% width/height if not visible, closes if visible
# Maintains persistent session that can be toggled on/off

POPUP_SESSION="popup"

# Get the current session name to detect if we're in the popup
CURRENT_SESSION=$(tmux display-message -p "#{session_name}" 2>/dev/null)
CURRENT_PATH=$(tmux display-message -p "#{pane_current_path}" 2>/dev/null)

if [ "$CURRENT_SESSION" = "$POPUP_SESSION" ]; then
	# We are inside the popup session - use async close for minimal message
	(
		sleep 0.005
		tmux display-popup -C 2>/dev/null
	) &
	tmux detach-client 2>/dev/null
	exit 0
fi

# We're not in the popup session, check if popup is visible from the main session
POPUP_VISIBLE=$(tmux display-message -p -F "#{popup_visible}" 2>/dev/null)

if [ "$POPUP_VISIBLE" = "1" ]; then
	# Popup is visible, close it
	tmux display-popup -C
else
	# Popup is not visible, open it
	# Check if our popup session exists
	if ! tmux has-session -t "$POPUP_SESSION" 2>/dev/null; then
		# Create a new detached session for the popup
		tmux new-session -d -s "$POPUP_SESSION" -c "$CURRENT_PATH"
	else
		# Sync popup working directory with the current pane
		tmux send-keys -t "$POPUP_SESSION":0 "cd \"$CURRENT_PATH\"" C-m
	fi

	# Open popup with the persistent session
	# -w 80%: 80% of terminal width
	# -h 80%: 80% of terminal height
	tmux display-popup -E -w 80% -h 80% "tmux attach-session -t $POPUP_SESSION"
fi
