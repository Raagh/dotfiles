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

  sessionKeybindings = ''
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

  # Special handling for session mode's own key (C-s) to allow toggling back to normal
  sessionModeConfig = ''
    # Override the default session mode binding to allow returning to normal
    bind -T root C-s run-shell "sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh" \; source-file ~/.config/tmux/tmux.conf
  '';

in
{
  home.file = {
    ".config/tmux/modes/session.conf" = {
      text = modeCommon.mkMode {
        modeName = "SESSION";
        modeColor = tmuxColors.sessionMode;
        keybindings = sessionKeybindings;
        additionalConfig = sessionModeConfig;
      };
    };
  };
}
