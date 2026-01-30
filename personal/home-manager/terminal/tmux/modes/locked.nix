{
  config,
  pkgs,
  ...
}:

{

  home.file = {
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
