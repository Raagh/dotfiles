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
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
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
      theme = "robbyrussell";
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
}
