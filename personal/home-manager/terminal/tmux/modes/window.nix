{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

{

  home.file = {
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
        bind -T root C-t run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
        bind -T root C-s source-file ~/.config/tmux/modes/session.conf
        bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
        bind -T root Escape run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; run-shell "sh ${personalDotfilesPath}/scripts/terminal/restore_normal_bindings.sh"
        bind -T root Enter run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; run-shell "sh ${personalDotfilesPath}/scripts/terminal/restore_normal_bindings.sh"

        # Window creation and management (stays in window mode)
        bind -T root n new-window -c "#{pane_current_path}"
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
  };
}
