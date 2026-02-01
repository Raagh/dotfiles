{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

{

  home.file = {
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
        bind -T root C-p run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/modes/pane.conf
        bind -T root C-t source-file ~/.config/tmux/modes/window.conf
        bind -T root C-s source-file ~/.config/tmux/modes/session.conf
        bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
        bind -T root C-l source-file ~/.config/tmux/modes/locked.conf
        bind -T root Escape run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout
        bind -T root Enter run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout

        # Pane creation (stays in pane mode)
        bind -T root n split-window -h -c "#{pane_current_path}"
        bind -T root d split-window -v -c "#{pane_current_path}"

        # Pane management (stays in pane mode)
        bind -T root x confirm-before -p "kill-pane? (y/n)" kill-pane
        bind -T root f resize-pane -Z
        bind -T root b break-pane
        bind -T root w run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b " \; unbind -T root -a \; bind -n M-H previous-window \; bind -n M-L next-window \; bind -n M-[ previous-layout \; bind -n M-] next-layout \; run-shell "sh ${personalDotfilesPath}/scripts/terminal/popup.sh"

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
  };
}
