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
    '';
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
}
