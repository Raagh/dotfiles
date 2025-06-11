{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

{
  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  # Packages to make hyprland a DE.
  home.packages = with pkgs; [
    # overskride
    blueberry
    networkmanagerapplet
    wdisplays
    nautilus
    pavucontrol
    wl-clipboard
    file-roller
    hyprpolkitagent
    hyprshot
    waypaper
  ];

  # link the hyprland config to the .config folder in home
  home.file = {
    ".config/hypr/hyprland.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${personalDotfilesPath}/config/hyprland.conf";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint Electron apps to use Wayland
    HYPRSHOT_DIR = "/home/raagh/Pictures/Screenshots";
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
