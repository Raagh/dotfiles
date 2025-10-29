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
            position = "0,0";
            status = "enable";
          }
        ];
      }
    ];
  };
}
