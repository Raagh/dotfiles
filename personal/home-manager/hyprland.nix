{
  config,
  pkgs,
  personalDotfilesPath,
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
    nwg-displays
    wdisplays
    nautilus
    pavucontrol
    wl-clipboard
    file-roller

    # mako
    # kanshi
    # waybar
    # udiskie
    # unzip
    # zip
    #
  ];

  # link the hyprland config to the .config folder in home
  home.file = {
    ".config/hypr/hyprland.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${personalDotfilesPath}/config/hyprland.conf";
  };

  # hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

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
