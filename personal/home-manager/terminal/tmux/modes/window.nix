{
  config,
  pkgs,
  ...
}:

{

  home.file = {
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
  };
}
