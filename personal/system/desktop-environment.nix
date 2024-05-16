{ pkgs, ... }:

let

  # bash script to let dbus know about important env variables and propogate them to relevent services
  # propogate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        export GTK_THEME=rose-pine
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'rose-pine'
        '';
  };
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raagh = {
    extraGroups = [ "video" ];
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Desktop Environment
  programs.sway = {
    enable = true;
     package = (pkgs.swayfx.overrideAttrs (old: {
       passthru.providedSessions = [ "sway" ];
       passthru.extraSessionCommands = ''
         export XDG_SESSION_TYPE=wayland
         export XDG_SESSION_DESKTOP=sway
         export XDG_CURRENT_DESKTOP=sway
         export QT_QPA_PLATFORM=wayland
         export CLUTTER_BACKEND=wayland
         export SDL_VIDEODRIVER=wayland
         export _JAVA_AWT_WM_NONREPARENTING=1
       '';
     })); 
    wrapperFeatures.gtk = true;
  };
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;
  programs.light.enable = true;

  # Login Manager
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.swayfx}/bin/sway";
        user = "raagh";
      };
      default_session = initial_session;
    };
  };
  systemd.user.services.kanshi = {
    description = "Kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
      RestartSec = 5;
      Restart = "always";
    };
  };

  environment.systemPackages = with pkgs; [
     dbus-sway-environment
     configure-gtk
     glib
     networkmanagerapplet
     blueberry
     kitty
     wdisplays
     rofi-wayland
     mako
     wl-clipboard
     kanshi
     waybar
     grim
     flameshot
     pavucontrol
     udiskie
     xfce.thunar
     xfce.thunar-volman
     xfce.thunar-archive-plugin

     # Theming
     qogir-theme
     gnome3.adwaita-icon-theme
     papirus-icon-theme
     rose-pine-gtk-theme
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
