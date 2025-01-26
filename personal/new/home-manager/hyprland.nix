{
  config,
  pkgs,
  ...
}:

{
  programs.kitty.enable = true;
  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  # link the hyprland config to the .config folder in home
  home.file = {
    ".config/hypr/hyprland.conf".source =
      config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/personal/new/config/hyprland.conf";
  };

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
