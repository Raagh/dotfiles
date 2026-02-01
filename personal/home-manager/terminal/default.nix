{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./tmux
  ];

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      window_padding_width = 4;
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --theme=base16";
      "cd.." = "cd ..";
      grep = "grep --color=auto";
      jctl = "journalctl -p 3 -xb"; # get the error messages from journalctl
      ls = "eza -lhF --color=always --icons --sort=size --group-directories-first";
      q = "exit";
      rg = "rg --sort path --no-ignore --hidden"; # search content with ripgrep
      rm = "rm -i";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "vi-mode"
      ];
    };
    initContent = ''
      autoload -Uz vcs_info

      precmd() { vcs_info }

      # Format the vcs_info_msg_0_ variable
      zstyle ':vcs_info:git:*' formats "%b"

      setopt prompt_subst

      PROMPT="%B%F{#${config.lib.stylix.colors.base0C}}% "" ❯ %f"
      RPROMPT='%F{#${config.lib.stylix.colors.base0C}}''${vcs_info_msg_0_}'

      # Auto-start tmux (like zellij enableZshIntegration)
      if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] && [[ -z "$SSH_CONNECTION" ]]; then
        # Try to attach to main session first, then any other session except popup
        if tmux has-session -t "main" 2>/dev/null; then
          exec tmux attach -t "main"
        elif tmux has-session 2>/dev/null; then
          # Attach to first session that's not the popup session
          MAIN_SESSION=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "popup" | head -1)
          if [[ -n "$MAIN_SESSION" ]]; then
            exec tmux attach -t "$MAIN_SESSION"
          else
            exec tmux new-session -s "main"
          fi
        else
          exec tmux new-session -s "main"
        fi
      fi
    '';
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };
}
