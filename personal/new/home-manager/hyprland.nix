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

  # Packages to make hyprland a DE.
  home.packages = with pkgs; [
    overskride # bluetooth tool
    #nwg-displays
    wdisplays
    nautilus
    pavucontrol
    wl-clipboard

    # mako
    # kanshi
    # waybar
    # udiskie
    #
    # zathura
    # exercism
    # transmission_4-gtk
    # unzip
    # gedit
    # vlc
    # galculator
  ];

  # link the hyprland config to the .config folder in home
  home.file = {
    ".config/hypr/hyprland.conf".source =
      config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/personal/new/config/hyprland.conf";
  };

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.gnome.gnome-keyring.enable = true;
  # security.polkit.enable = true;

  # systemd.user.services.kanshi = {
  #   description = "Kanshi daemon";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
  #     RestartSec = 5;
  #     Restart = "always";
  #   };
  # };
}
