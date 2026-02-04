{ personalDotfilesPath, tmuxColors }:

let
  c = tmuxColors;

  # Generate status bar configuration for a specific mode
  mkModeStatus =
    { modeName, modeColor }:
    ''
      set -g status-right '#[fg=#${c.background},bg=#${modeColor},bold] ${modeName} #[fg=#${c.foreground},bg=#${c.background}] %H:%M #[fg=#${c.backgroundMuted}]#[fg=#${c.foreground},bg=#${c.backgroundMuted}] #[fg=#${c.accent},bg=#${c.backgroundMuted}]#[fg=#${c.background},bg=#${c.accent},bold] %d %b '
    '';

  # Generate the normal mode status bar (used when exiting modes)
  normalStatus = ''set -g status-right "#[fg=#${c.backgroundMuted}]#[fg=#${c.foreground},bg=#${c.backgroundMuted}] %H:%M #[fg=#${c.accent},bg=#${c.backgroundMuted}]#[fg=#${c.background},bg=#${c.accent},bold] %d %b "'';

  # Common mode initialization (prevents input, sets up hooks)
  modeInit = ''
    # Unbind all root bindings to prevent conflicts
    unbind -T root -a

    # Prevent input while in mode
    select-pane -d
    set-hook -g client-attached "select-pane -d"
    set-hook -g client-focus-in "select-pane -d"
    set-hook -g window-pane-changed "select-pane -d"
    set-hook -g session-window-changed "select-pane -d"
  '';

  # Common mode switching bindings (Ctrl+p/t/s/r for switching between modes)
  modeSwitching = ''
    # Mode switching (available in all modes)
    bind -T root C-p source-file ~/.config/tmux/modes/pane.conf
    bind -T root C-t source-file ~/.config/tmux/modes/window.conf
    bind -T root C-s source-file ~/.config/tmux/modes/session.conf
    bind -T root C-r source-file ~/.config/tmux/modes/resize.conf
  '';

  # Generate mode exit bindings (Escape/Enter) with normal mode restoration
  mkModeExits =
    let
      exitCommand = "run-shell \"sh ${personalDotfilesPath}/scripts/terminal/return_to_normal.sh\" \\; ${normalStatus} \\; run-shell \"sh ${personalDotfilesPath}/scripts/terminal/restore_normal_bindings.sh\"";
    in
    ''
      bind -T root Escape ${exitCommand}
      bind -T root Enter ${exitCommand}
    '';

  # Generate a complete mode configuration
  mkMode =
    {
      modeName,
      modeColor,
      keybindings ? "",
      additionalConfig ? "",
    }:
    ''
      # ===============================================
      # ${modeName} MODE (${modeColor})
      # ===============================================
      # Exit with: Escape or Enter

      ${mkModeStatus { inherit modeName modeColor; }}

      ${modeInit}

      ${modeSwitching}

      ${mkModeExits}

      ${keybindings}

      ${additionalConfig}
    '';

in
{
  inherit
    mkMode
    mkModeStatus
    normalStatus
    modeInit
    modeSwitching
    mkModeExits
    ;
}
