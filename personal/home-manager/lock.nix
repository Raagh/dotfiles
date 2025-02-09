{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hypridle
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      ignore_empty_input = true;
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };
    };
  };
}
