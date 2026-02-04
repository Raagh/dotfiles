{
  config,
  pkgs,
  personalDotfilesPath,
  tmuxColors,
  ...
}:

let
  modeCommon = import ./common.nix {
    inherit personalDotfilesPath tmuxColors;
  };

  resizeKeybindings = ''
    # Resize panes (stays in resize mode, repeatable)
    bind -T root -r h resize-pane -L 10
    bind -T root -r j resize-pane -D 10
    bind -T root -r k resize-pane -U 10
    bind -T root -r l resize-pane -R 10
  '';

  # Special handling for resize mode's own key (C-r) to allow toggling back to normal
  resizeModeConfig = ''
    # Override the default resize mode binding to allow returning to normal
    bind -T root C-r run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
  '';

in
{
  home.file = {
    ".config/tmux/modes/resize.conf" = {
      text = modeCommon.mkMode {
        modeName = "RESIZE";
        modeColor = tmuxColors.resizeMode;
        keybindings = resizeKeybindings;
        additionalConfig = resizeModeConfig;
      };
    };
  };
}
