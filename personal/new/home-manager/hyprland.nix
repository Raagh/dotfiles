{ config, pkgs, ... }:

{
  programs.kitty.enable = true;
  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  # link the hyprland config to the .config folder in home
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./config/hyprland.conf;

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
