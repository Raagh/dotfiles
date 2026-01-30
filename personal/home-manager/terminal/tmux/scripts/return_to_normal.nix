{
  config,
  pkgs,
  ...
}:

{

  # Tmux modal system files
  home.file = {
    ".config/tmux/scripts/return_to_normal.sh" = {
      text = ''
        #!/bin/bash
        # Enable input on all panes and clear mode hooks
        tmux list-panes -s -F "#{session_name}:#{window_index}.#{pane_index}" |
        	xargs -I {} tmux select-pane -t {} -e

        # Clear all the input-blocking hooks
        tmux set-hook -gu client-attached
        tmux set-hook -gu client-focus-in
        tmux set-hook -gu window-pane-changed
        tmux set-hook -gu session-window-changed
      '';
      executable = true;
    };

  };
}
