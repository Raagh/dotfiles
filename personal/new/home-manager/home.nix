{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  home.username = "raagh";
  home.homeDirectory = "/home/raagh";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    google-chrome
    lazygit
    stow
  ];

  programs.git = {
    enable = true;
    userName = "Raagh";
    userEmail = "pattferraggi@gmail.com";
  };

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

  # link the neovim config in shared directory to the .config folder in home
  home.file.".config/nvim/" = { source = ../../../shared/nvim; recursive = true; };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
