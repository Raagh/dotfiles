{
  config,
  pkgs,
  ...
}:

{

  home.file = {
    ".config/tmux/scripts/popup.sh" = {
      text = ''
        #!/bin/bash
        # Toggleable popup terminal window
        # Opens a popup at 80% width/height if not visible, closes if visible

        if tmux display-message -p -F "#{popup_visible}" 2>/dev/null | grep -q "1"; then
        	# Popup is visible, close it
        	tmux display-popup -C
        else
        	# Popup is not visible, open it
        	# -E: close popup when shell exits
        	# -w 80%: 80% of terminal width
        	# -h 80%: 80% of terminal height
        	tmux display-popup -E -w 80% -h 80%
        fi
      '';
      executable = true;
    };
  };
}
