{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

let
  # Tmux-specific color mappings from stylix
  base = config.lib.stylix.colors;
  tmuxColors = {
    # Background and text colors
    background = base.base00;
    backgroundAlt = base.base02;
    backgroundMuted = base.base03;
    foreground = base.base05;

    # Mode colors (for status bar indicators)
    paneMode = base.base0B; # GREEN - Pane management
    windowMode = base.base0A; # YELLOW - Window/tab management
    sessionMode = base.base0C; # BLUE - Session management
    resizeMode = base.base0E; # PURPLE - Pane resizing

    # UI accent colors
    accent = base.base0C; # Primary accent (cyan/blue)
    highlight = base.base0A; # Highlight color (yellow)
    border = base.base03; # Inactive borders
    borderActive = base.base0C; # Active borders

    # Status and message colors
    statusBg = base.base00; # Status bar background
    statusFg = base.base05; # Status bar text
    messageBg = base.base0A; # Message background
    messageFg = base.base00; # Message text (dark on light)

    # Window status colors
    windowCurrent = base.base0A; # Current window highlight
    windowInactive = base.base02; # Inactive window background
  };
  c = tmuxColors;
in
{
  # Pass colors to imported modules through config
  _module.args = {
    inherit tmuxColors;
  };

  imports = [
    ./modes/pane.nix
    ./modes/resize.nix
    ./modes/session.nix
    ./modes/window.nix
  ];

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

      # Better copy mode with clipboard integration
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

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
      run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh"

      # Clear all root table bindings first (removes any mode bindings)
      unbind -T root -a

      # Mode switching bindings (Ctrl+g + key)
      bind p source-file ~/.config/tmux/modes/pane.conf     # Pane mode (GREEN)
      bind t source-file ~/.config/tmux/modes/window.conf   # Window mode (YELLOW)
      bind s source-file ~/.config/tmux/modes/session.conf  # Session mode (BLUE)
      bind r source-file ~/.config/tmux/modes/resize.conf   # Resize mode (PURPLE)

      # Root table bindings (work without prefix, survive mode exits)
      # These are re-established each time we return to normal mode
      bind -n M-H previous-window
      bind -n M-L next-window
      bind -n M-[ previous-layout
      bind -n M-] next-layout

      # ===============================================
      # MOUSE SUPPORT (Normal Mode Only)
      # ===============================================
      # Restore default mouse bindings after clearing root table
      # These bindings enable full mouse support in normal mode
      # Mouse will be disabled when entering any mode (pane/window/resize/session)

      # Click on status bar window name to select window
      bind -n MouseDown1Status select-window -t =

      # Click on pane to select it
      bind -n MouseDown1Pane 'select-pane -t = ; send-keys -M'

      # Drag pane border to resize
      bind -n MouseDrag1Border resize-pane -M

      # Drag in pane to select text (enters copy mode)
      bind -n MouseDrag1Pane if -Ft = "#{||:#{pane_in_mode},#{mouse_any_flag}}" "send-keys -M" "copy-mode -M"

      # Scroll wheel up (enters copy mode if not already in it)
      bind -n WheelUpPane if -Ft = "#{||:#{pane_in_mode},#{mouse_any_flag}}" "send-keys -M" "copy-mode -e"

      # Scroll wheel down
      bind -n WheelDownPane send-keys -M

      # Right click on pane (paste)
      bind -n MouseDown3Pane 'if -Ft = "#{||:#{mouse_any_flag},#{pane_in_mode}}" "select-pane -t = ; send-keys -M" "select-pane -mt ="'

      # Drag window in status bar to reorder
      bind -n MouseDrag1StatusLeft swap-window -dt =

      # Double click to select word
      bind -n DoubleClick1Pane 'select-pane -t = ; copy-mode -M ; send-keys -X select-word'

      # Triple click to select line
      bind -n TripleClick1Pane 'select-pane -t = ; copy-mode -M ; send-keys -X select-line'

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
      set -g status-style "fg=#${c.statusFg},bg=#${c.statusBg}"

      # Left status (session info)
      set -g status-left-length 100
      set -g status-left "#[fg=#${c.statusBg},bg=#${c.accent},bold] #S #[fg=#${c.accent},bg=#${c.statusBg}]"

      # Right status (system info)
      set -g status-right-length 100
      set -g status-right "#[fg=#${c.backgroundMuted}]#[fg=#${c.foreground},bg=#${c.backgroundMuted}] %H:%M #[fg=#${c.accent},bg=#${c.backgroundMuted}]#[fg=#${c.statusBg},bg=#${c.accent},bold] %d %b "

      # Window status (with clickable ranges for mouse support)
      set -g window-status-current-style "fg=#${c.statusBg},bg=#${c.windowCurrent},bold"
      set -g window-status-current-format "#[range=window|#{window_index}] #I #W #[norange]"
      set -g window-status-style "fg=#${c.foreground},bg=#${c.windowInactive}"
      set -g window-status-format "#[range=window|#{window_index}] #I #W #[norange]"
      set -g window-status-separator ""

      # Pane borders (modern look)
      set -g pane-border-style "fg=#${c.border}"
      set -g pane-active-border-style "fg=#${c.borderActive}"

      # Message styling
      set -g message-style "fg=#${c.messageFg},bg=#${c.messageBg}"
      set -g message-command-style "fg=#${c.messageFg},bg=#${c.messageBg}"

      # Copy mode styling
      set -g mode-style "fg=#${c.messageFg},bg=#${c.messageBg}"

      # Clock color
      set -g clock-mode-colour "#${c.accent}"
    '';
  };
}
