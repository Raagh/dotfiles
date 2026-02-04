{
  config,
  pkgs,
  personalDotfilesPath,
  tmuxColors,
  ...
}:

let
  modeCommon = import ../mode-common.nix {
    inherit personalDotfilesPath tmuxColors;
  };

  windowKeybindings = ''
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

  # Special handling for window mode's own key (C-t) to allow toggling back to normal
  windowModeConfig = ''
    # Override the default window mode binding to allow returning to normal
    bind -T root C-t run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
  '';

in
{
  home.file = {
    ".config/tmux/modes/window.conf" = {
      text = modeCommon.mkMode {
        modeName = "WINDOW";
        modeColor = tmuxColors.windowMode;
        keybindings = windowKeybindings;
        additionalConfig = windowModeConfig;
      };
    };
  };
}
