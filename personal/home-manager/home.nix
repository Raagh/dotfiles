{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./hyprpanel.nix
    ./rofi.nix
    ./neovim.nix
    ./zsh.nix
    ./theme.nix
  ];

  home.username = "raagh";
  home.homeDirectory = "/home/raagh";
  home.file.".face.icon" = {
    source = ../assets/profile_picture.jpeg;
  };

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
    kitty
    zellij

    # zathura
    # exercism
    # transmission_4-gtk
    # gedit
    # vlc
    # galculator
  ];

  programs.git = {
    enable = true;
    userName = "Raagh";
    userEmail = "pattferraggi@gmail.com";
  };

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
