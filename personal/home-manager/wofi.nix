{
  config,
  pkgs,
  ...
}:

{
  programs.wofi = {
    enable = true;
  };

  # # Packages to make hyprland a DE.
  # home.packages = with pkgs; [
  #   rofi-wayland
  # ];
  #
  # # link the hyprland config to the .config folder in home
  # home.file = {
  #   ".config/rofi/".source =
  #     config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/personal/config/rofi/";
  # };
}
