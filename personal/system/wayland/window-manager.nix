{ config, pkgs, lib, ... }:

let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-enviroment";
    executable = true;

    text = ''
      dbus-update-activation-enviroment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure/-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsetting-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'WhiteSur-dark'
        gsettings set $gnome_schema cursor-theme 'capitaine-cursors-white'
      '';
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environment.
  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 30;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

in
{
  environment.systemPackages = with pkgs; [
    blueberry
    networkmanagerapplet
    rofi-wayland
    waybar
    wdisplays # monitor setup
    mako # notification system developed by swaywm maintainer
    kitty
    sway
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils
    glib
    whitesur-icon-theme
    grim
    slurp
    wl-clipboard
    capitaine-cursors
    libsForQt5.dolphin
  ];

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
}
