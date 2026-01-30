{
  config,
  pkgs,
  ...
}:

{

  imports = [
    ./scripts/return_to_normal.nix
    ./scripts/popup.nix
    ./modes/locked.nix
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
}
