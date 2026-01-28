{
  config,
  pkgs,
  ...
}:

{
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
        # Try to attach to existing session, or create new one
        if tmux has-session 2>/dev/null; then
          exec tmux attach
        else
          exec tmux new-session
        fi
      fi
    '';
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  # programs.zellij = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-g";
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "tmux-256color";
    historyLimit = 10000;

    extraConfig = ''
      # True color support
      set -ga terminal-overrides ",xterm-256color*:Tc"
      set -as terminal-features ",xterm-256color:RGB"

      # Enable image passthrough (critical for neovim image support)
      set -gq allow-passthrough on
      set -g visual-activity off

      # Pane numbering starts from 1
      set -g pane-base-index 1

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Monitor activity but don't show notifications
      setw -g monitor-activity on
      set -g visual-activity off

      # Vi mode keys
      set-window-option -g mode-keys vi

      # Better copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Quick pane cycling
      bind -r Tab select-pane -t :.+

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # Clear screen and history
      bind C-l send-keys 'C-l'

      # ===============================================
      # ZELLIJ-STYLE CHORD KEYBINDINGS
      # ===============================================
      # After pressing Ctrl+g, you can press single letters without holding Ctrl

      # Tab/Window management mode (Ctrl+g, then t)
      bind t switch-client -T tab_mode
      bind -T tab_mode n new-window -c "#{pane_current_path}"
      bind -T tab_mode c new-window -c "#{pane_current_path}"  
      bind -T tab_mode x confirm-before -p "kill-window #W? (y/n)" kill-window
      bind -T tab_mode r command-prompt "rename-window %%"
      bind -T tab_mode h previous-window
      bind -T tab_mode l next-window
      bind -T tab_mode 1 select-window -t 1
      bind -T tab_mode 2 select-window -t 2
      bind -T tab_mode 3 select-window -t 3
      bind -T tab_mode 4 select-window -t 4
      bind -T tab_mode 5 select-window -t 5
      bind -T tab_mode 6 select-window -t 6
      bind -T tab_mode 7 select-window -t 7
      bind -T tab_mode 8 select-window -t 8
      bind -T tab_mode 9 select-window -t 9
      bind -T tab_mode 0 select-window -t 10
      bind -T tab_mode Tab last-window
      bind -T tab_mode Escape switch-client -T root

      # Pane management mode (Ctrl+g, then p)  
      bind p switch-client -T pane_mode
      bind -T pane_mode n split-window -h -c "#{pane_current_path}"
      bind -T pane_mode d split-window -v -c "#{pane_current_path}"
      bind -T pane_mode x confirm-before -p "kill-pane? (y/n)" kill-pane
      bind -T pane_mode f resize-pane -Z
      bind -T pane_mode h select-pane -L
      bind -T pane_mode j select-pane -D  
      bind -T pane_mode k select-pane -U
      bind -T pane_mode l select-pane -R
      bind -T pane_mode Tab select-pane -t :.+
      bind -T pane_mode w display-panes
      bind -T pane_mode Escape switch-client -T root
      bind -T pane_mode J swap-pane -D
      bind -T pane_mode K swap-pane -U

      # Session management mode (Ctrl+g, then s)
      bind s switch-client -T session_mode  
      bind -T session_mode n command-prompt "new-session -s %%"
      bind -T session_mode r command-prompt "rename-session %%"
      bind -T session_mode l choose-session
      bind -T session_mode d detach-client
      bind -T session_mode x confirm-before -p "kill-session #S? (y/n)" kill-session
      bind -T session_mode Escape switch-client -T root

      # Quick actions (single key after Ctrl+g)
      bind q display-panes
      bind w choose-window
      bind e choose-session  
      bind / copy-mode \; send-keys ?

      # Keep some original bindings for compatibility
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Status bar configuration (zellij-inspired)
      set -g status on
      set -g status-interval 2
      set -g status-position bottom
      set -g status-justify left
      set -g status-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base00}"

      # Left status (session info)
      set -g status-left-length 100
      set -g status-left "#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] #S #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base00}]"

      # Right status (system info)
      set -g status-right-length 100
      set -g status-right "#[fg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base03}] %H:%M #[fg=#${config.lib.stylix.colors.base0C},bg=#${config.lib.stylix.colors.base03}]#[fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0C},bold] %d %b "

      # Window status
      set -g window-status-current-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A},bold"
      set -g window-status-current-format " #I #W "
      set -g window-status-style "fg=#${config.lib.stylix.colors.base05},bg=#${config.lib.stylix.colors.base02}"
      set -g window-status-format " #I #W "
      set -g window-status-separator ""

      # Pane borders (modern look)
      set -g pane-border-style "fg=#${config.lib.stylix.colors.base03}"
      set -g pane-active-border-style "fg=#${config.lib.stylix.colors.base0C}"

      # Message styling
      set -g message-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"
      set -g message-command-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"

      # Copy mode styling
      set -g mode-style "fg=#${config.lib.stylix.colors.base00},bg=#${config.lib.stylix.colors.base0A}"

      # Clock color
      set -g clock-mode-colour "#${config.lib.stylix.colors.base0C}"
    '';
  };
}
