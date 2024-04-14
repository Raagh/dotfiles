{ config, pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raagh = {
    extraGroups = [ "video" ];
  };

  # Desktop Environment
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.hyprland = {
    enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;
  programs.light.enable = true;

  # Login Manager
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.defaultSession = "hyprland";

  systemd.user.services.kanshi = {
    description = "Kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  environment.systemPackages = with pkgs; [
     networkmanagerapplet
     blueberry
     kitty
     wdisplays
     rofi-wayland
     mako
     wl-clipboard
     slurp
     kanshi
     udiskie
     gnome.nautilus
  ];

  fonts.packages = with pkgs; [
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    source-code-pro
    inter
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  ];
}
