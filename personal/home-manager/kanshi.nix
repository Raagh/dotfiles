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
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 2.0;
            position = "0,0";
            mode = "3840x2400@59.99Hz";
            status = "enable";
          }
        ];
      }
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
