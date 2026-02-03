#!/bin/bash
# Restore normal mode bindings (keyboard shortcuts + mouse support)
# This script is called when exiting any modal mode

# Clear all root table bindings first
tmux unbind -T root -a

# Restore keyboard shortcuts (work without prefix)
tmux bind -n M-H previous-window
tmux bind -n M-L next-window
tmux bind -n M-[ previous-layout
tmux bind -n M-] next-layout

# ===============================================
# Restore Mouse Support Bindings
# ===============================================

# Click on status bar window name to select window
tmux bind -n MouseDown1Status select-window -t =

# Click on pane to select it
tmux bind -n MouseDown1Pane select-pane -t = \\\; send-keys -M

# Drag pane border to resize
tmux bind -n MouseDrag1Border resize-pane -M

# Drag in pane to select text (enters copy mode)
tmux bind -n MouseDrag1Pane if -Ft = "#{||:#{pane_in_mode},#{mouse_any_flag}}" "send-keys -M" "copy-mode -M"

# Scroll wheel up (enters copy mode if not already in it)
tmux bind -n WheelUpPane if -Ft = "#{||:#{pane_in_mode},#{mouse_any_flag}}" "send-keys -M" "copy-mode -e"

# Scroll wheel down
tmux bind -n WheelDownPane send-keys -M

# Right click on pane (paste)
tmux bind -n MouseDown3Pane if -Ft = "#{||:#{mouse_any_flag},#{pane_in_mode}}" "select-pane -t = \\\; send-keys -M" "select-pane -mt ="

# Drag window in status bar to reorder
tmux bind -n MouseDrag1StatusLeft swap-window -dt =

# Double click to select word
tmux bind -n DoubleClick1Pane select-pane -t = \\\; copy-mode -M \\\; send-keys -X select-word

# Triple click to select line
tmux bind -n TripleClick1Pane select-pane -t = \\\; copy-mode -M \\\; send-keys -X select-line
