{
  config,
  pkgs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "vi-mode"
      ];
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };

  # link the zsh config to the .config folder in home
  home.file = {
    ".zshrc".source =
      config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/personal/config/zsh/.zshrc";
  };

  home.file = {
    ".zshrc-personal".source =
      config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/personal/config/zsh/.zshrc-personal";
  };
}
