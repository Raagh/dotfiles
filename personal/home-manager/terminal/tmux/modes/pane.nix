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

  paneKeybindings =
    let
      popupCommand = "run-shell \"sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh\" \\; ${modeCommon.normalStatus} \\; run-shell \"sh ${personalDotfilesPath}/scripts/terminal/restore_normal_bindings.sh\" \\; run-shell \"sh ${personalDotfilesPath}/scripts/terminal/popup.sh\"";
    in
    ''
      # Pane creation (stays in pane mode)
      bind -T root n split-window -h -c "#{pane_current_path}"
      bind -T root d split-window -v -c "#{pane_current_path}"

      # Pane management (stays in pane mode)
      bind -T root x confirm-before -p "kill-pane? (y/n)" kill-pane
      bind -T root f resize-pane -Z
      bind -T root b break-pane
      bind -T root w ${popupCommand}

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

  # Special handling for pane mode's own key (C-p) to allow toggling back to normal
  paneModeConfig = ''
    # Override the default pane mode binding to allow returning to normal
    bind -T root C-p run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/modes/pane.conf
  '';

in
{
  home.file = {
    ".config/tmux/modes/pane.conf" = {
      text = modeCommon.mkMode {
        modeName = "PANE";
        modeColor = tmuxColors.paneMode;
        keybindings = paneKeybindings;
        additionalConfig = paneModeConfig;
      };
    };
  };
}
