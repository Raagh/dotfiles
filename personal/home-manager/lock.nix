{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    hypridle
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        # Disable hyprlock gracefully on display changes to prevent crashes
        grace = 2;
      };

      background = lib.mkForce [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 1;
          blur_size = 3;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "sleep 1 && pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
    };
  };
}
