{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./lock.nix
    ./rofi.nix
    ./waybar.nix
    ./terminal.nix
    ./swaync.nix
    ./theme.nix
    ./programs.nix
    ./neovim.nix
    ./kanshi.nix
  ];

  home.username = "raagh";
  home.homeDirectory = "/home/raagh";

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
