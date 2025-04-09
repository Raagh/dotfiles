{
  config,
  pkgs,
  ...
}:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "xdg-desktop-portal-hyprland.service";
    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-7";
            mode = "3440x1440@60.00Hz";
            position = "0,0";
            status = "enable";
          }
        ];
      }
    ];
  };
}
