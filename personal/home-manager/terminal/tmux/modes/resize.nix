{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

{

  home.file = {
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
        bind -T root C-r run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Resize panes (stays in resize mode, repeatable)
        bind -T root -r h resize-pane -L 10
        bind -T root -r j resize-pane -D 10
        bind -T root -r k resize-pane -U 10
        bind -T root -r l resize-pane -R 10
      '';
    };
  };
}
