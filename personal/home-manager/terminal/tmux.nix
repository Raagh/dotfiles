{
  config,
  pkgs,
  ...
}:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-g";
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 10000;

    extraConfig = ''
      # True color support
      set -ga terminal-overrides ",xterm-256color*:Tc"
      set -as terminal-features ",xterm-256color:RGB"

      # Enable image passthrough (critical for neovim image support)
      set -gq allow-passthrough on
      set -g visual-activity off

      # Pane numbering starts from 1
      set -g pane-base-index 1

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Monitor activity but don't show notifications
      setw -g monitor-activity on
      set -g visual-activity off

      # Vi mode keys
      set-window-option -g mode-keys vi

      # Better copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Pane navigation (vim-like)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Pane splitting with better keys
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Quick pane cycling
      bind -r Tab select-pane -t :.+

      # Reload config
      bind R source-file ~/.config/tmux/tmux.conf

      # Clear screen and history
      bind C-l send-keys 'C-l'

      # ===============================================
      # MODAL SYSTEM (Zellij-inspired with input blocking)
      # ===============================================
      # After pressing Ctrl+g, press a mode key to enter that mode
      # Modes block terminal input and show colored status bar indicators
      # Press Escape or Enter in any mode to return to normal mode

      # Ensure we're in normal mode on config load - clear any blocking hooks
      run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh"

      # Clear all root table bindings first (removes any mode bindings)
      unbind -T root -a

      # Mode switching bindings (Ctrl+g + key)
      bind p source-file ~/.config/tmux/modes/pane.conf     # Pane mode (GREEN)
      bind t source-file ~/.config/tmux/modes/window.conf   # Window mode (YELLOW)
      bind s source-file ~/.config/tmux/modes/session.conf  # Session mode (BLUE)
      bind r source-file ~/.config/tmux/modes/resize.conf   # Resize mode (PURPLE)
      bind l source-file ~/.config/tmux/modes/locked.conf   # Locked mode (RED)

      # Root table bindings (work without prefix, survive mode exits)
      # These are re-established each time we return to normal mode
      bind -n M-H previous-window
      bind -n M-L next-window
      bind -n M-[ previous-layout
      bind -n M-] next-layout

      # Quick actions (single key after Ctrl+g)
      bind q display-panes
      bind w choose-window
      bind e choose-session  
      bind / copy-mode \; send-keys ?
      bind : command-prompt

      # Status bar configuration (modal system with stylix colors)
      set -g status on
      set -g status-interval 2
      set -g status-position top
      set -g status-justify left
      set -g status-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}"

      # Left status (session info)
      set -g status-left-length 100
      set -g status-left "#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] #S #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base00}]"

      # Right status (system info)
      set -g status-right-length 100
      set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b "

      # Window status
      set -g window-status-current-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A},bold"
      set -g window-status-current-format " #I #W "
      set -g window-status-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}"
      set -g window-status-format " #I #W "
      set -g window-status-separator ""

      # Pane borders (modern look)
      set -g pane-border-style "fg=#${config.lib.stylix.colors.base03}"
      set -g pane-active-border-style "fg=#${config.lib.stylix.colors.base0C}"

      # Message styling
      set -g message-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"
      set -g message-command-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"

      # Copy mode styling
      set -g mode-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"

      # Clock color
      set -g clock-mode-colour "#${config.lib.stylix.colors.base0C}"
    '';
  };

  # Tmux modal system files
  home.file = {
    ".config/tmux/scripts/return_to_normal.sh" = {
      text = ''
        #!/bin/bash
        # Enable input on all panes and clear mode hooks
        tmux list-panes -s -F "#{session_name}:#{window_index}.#{pane_index}" |
        	xargs -I {} tmux select-pane -t {} -e

        # Clear all the input-blocking hooks
        tmux set-hook -gu client-attached
        tmux set-hook -gu client-focus-in
        tmux set-hook -gu window-pane-changed
        tmux set-hook -gu session-window-changed
      '';
      executable = true;
    };

    ".config/tmux/scripts/popup.sh" = {
      text = ''
        #!/bin/bash
        # Toggleable popup terminal window
        # Opens a popup at 80% width/height if not visible, closes if visible

        if tmux display-message -p -F "#{popup_visible}" 2>/dev/null | grep -q "1"; then
        	# Popup is visible, close it
        	tmux display-popup -C
        else
        	# Popup is not visible, open it
        	# -E: close popup when shell exits
        	# -w 80%: 80% of terminal width
        	# -h 80%: 80% of terminal height
        	tmux display-popup -E -w 80% -h 80%
        fi
      '';
      executable = true;
    };

    ".config/tmux/modes/pane.conf" = {
      text = ''
        # ===============================================
        # PANE MODE - Pane Management (GREEN)
        # ===============================================
        # Activated with: Ctrl+g p
        # Exit with: Escape or Enter

        # Status should reflect pane mode
        set -g status-right '#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0B},bold] PANE #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] %H:%M #[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b '

        # Unbind all root bindings to prevent conflicts
        unbind -T root -a

        # Prevent input while in mode
        select-pane -d
        set-hook -g client-attached "select-pane -d"
        set-hook -g client-focus-in "select-pane -d"
        set-hook -g window-pane-changed "select-pane -d"
        set-hook -g session-window-changed "select-pane -d"

        # Mode switching (available in all modes)
        bind -T root C-p run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; source-file ~/.config/tmux/modes/pane.conf
        bind -T root C-t source-file ~/.config/tmux/modes/window.conf
        bind -T root C-s source-file ~/.config/tmux/modes/session.conf
        bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Pane creation (stays in pane mode)
        bind -T root n split-window -h -c "#{pane_current_path}"
        bind -T root d split-window -v -c "#{pane_current_path}"

        # Pane management (stays in pane mode)
        bind -T root x confirm-before -p "kill-pane? (y/n)" kill-pane
        bind -T root f resize-pane -Z
        bind -T root b break-pane
        bind -T root w run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout \; run-shell "sh ~/.config/tmux/scripts/popup.sh"

        # Pane navigation (stays in pane mode)
        bind -T root h select-pane -L
        bind -T root j select-pane -D
        bind -T root k select-pane -U
        bind -T root l select-pane -R
        bind -T root Tab select-pane -t :.+

        # Pane swapping (stays in pane mode)
        bind -T root J swap-pane -D
        bind -T root K swap-pane -U

        # Display pane numbers (stays in pane mode)
        bind -T root q display-panes
      '';
    };

    ".config/tmux/modes/window.conf" = {
      text = ''
        # ===============================================
        # WINDOW MODE - Window/Tab Management (YELLOW)
        # ===============================================
        # Activated with: Ctrl+g t
        # Exit with: Escape or Enter

        # Status should reflect window mode
        set -g status-right '#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A},bold] WINDOW #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] %H:%M #[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b '

        # Unbind all root bindings to prevent conflicts
        unbind -T root -a

        # Prevent input while in mode
        select-pane -d
        set-hook -g client-attached "select-pane -d"
        set-hook -g client-focus-in "select-pane -d"
        set-hook -g window-pane-changed "select-pane -d"
        set-hook -g session-window-changed "select-pane -d"

        # Mode switching (available in all modes)
        bind -T root C-p source-file ~/.config/tmux/modes/pane.conf
        bind -T root C-t run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
        bind -T root C-s source-file ~/.config/tmux/modes/session.conf
        bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Window creation and management (stays in window mode)
        bind -T root n new-window -c "#{pane_current_path}"
        bind -T root c new-window -c "#{pane_current_path}"
        bind -T root x confirm-before -p "kill-window #W? (y/n)" kill-window
        bind -T root r command-prompt -I "#W" "rename-window '%%'"

        # Layout management (stays in window mode)
        bind -T root g next-layout

        # Window navigation (stays in window mode)
        bind -T root h previous-window
        bind -T root l next-window
        bind -T root Tab last-window

        # Window selection by number (stays in window mode)
        bind -T root 1 select-window -t 1
        bind -T root 2 select-window -t 2
        bind -T root 3 select-window -t 3
        bind -T root 4 select-window -t 4
        bind -T root 5 select-window -t 5
        bind -T root 6 select-window -t 6
        bind -T root 7 select-window -t 7
        bind -T root 8 select-window -t 8
        bind -T root 9 select-window -t 9
        bind -T root 0 select-window -t 10
      '';
    };

    ".config/tmux/modes/session.conf" = {
      text = ''
        # ===============================================
        # SESSION MODE - Session Management (BLUE)
        # ===============================================
        # Activated with: Ctrl+g s
        # Exit with: Escape or Enter

        # Status should reflect session mode
        set -g status-right '#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] SESSION #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] %H:%M #[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b '

        # Unbind all root bindings to prevent conflicts
        unbind -T root -a

        # Prevent input while in mode
        select-pane -d
        set-hook -g client-attached "select-pane -d"
        set-hook -g client-focus-in "select-pane -d"
        set-hook -g window-pane-changed "select-pane -d"
        set-hook -g session-window-changed "select-pane -d"

        # Mode switching (available in all modes)
        bind -T root C-p source-file ~/.config/tmux/modes/pane.conf
        bind -T root C-t source-file ~/.config/tmux/modes/window.conf
        bind -T root C-s run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
        bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Session management (stays in session mode)
        bind -T root n command-prompt "new-session -s '%%'"
        bind -T root r command-prompt -I "#S" "rename-session '%%'"
        bind -T root l choose-tree
        bind -T root x confirm-before -p "kill-session #S? (y/n)" kill-session
        bind -T root d detach-client

        # Utilities (stays in session mode)
        bind -T root e copy-mode
        bind -T root c customize-mode -Z
        bind -T root : command-prompt
      '';
    };

    ".config/tmux/modes/resize.conf" = {
      text = ''
        # ===============================================
        # RESIZE MODE - Pane Resizing (PURPLE)
        # ===============================================
        # Activated with: Ctrl+g r
        # Exit with: Escape or Enter

        # Status should reflect resize mode
        set -g status-right '#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0E},bold] RESIZE #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] %H:%M #[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b '

        # Unbind all root bindings to prevent conflicts
        unbind -T root -a

        # Prevent input while in mode
        select-pane -d
        set-hook -g client-attached "select-pane -d"
        set-hook -g client-focus-in "select-pane -d"
        set-hook -g window-pane-changed "select-pane -d"
        set-hook -g session-window-changed "select-pane -d"

        # Mode switching (available in all modes)
        bind -T root C-p source-file ~/.config/tmux/modes/pane.conf
        bind -T root C-t source-file ~/.config/tmux/modes/window.conf
        bind -T root C-s source-file ~/.config/tmux/modes/session.conf
        bind -T root C-r run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Resize panes (stays in resize mode, repeatable)
        bind -T root -r h resize-pane -L 10
        bind -T root -r j resize-pane -D 10
        bind -T root -r k resize-pane -U 10
        bind -T root -r l resize-pane -R 10
      '';
    };

    ".config/tmux/modes/locked.conf" = {
      text = ''
        # ===============================================
        # LOCKED MODE - Input Blocking (RED)
        # ===============================================
        # Activated with: Ctrl+g l
        # Exit with: Ctrl+g (unlock)

        # Status should reflect locked mode
        set -g status-right '#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base08},bold] LOCKED #[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}] %H:%M #[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b '

        # Unbind ALL root bindings - complete input lockdown
        unbind -T root -a

        # Prevent input while in mode
        select-pane -d
        set-hook -g client-attached "select-pane -d"
        set-hook -g client-focus-in "select-pane -d"
        set-hook -g window-pane-changed "select-pane -d"
        set-hook -g session-window-changed "select-pane -d"

        # ONLY allow Ctrl+g to unlock and return to normal mode
        bind -T root C-g run-shell "sh ~/.config/tmux/scripts/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
      '';
    };
  };
}
