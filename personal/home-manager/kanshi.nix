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
            position = "0,0";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked-1";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-11";
            position = "0,0";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked-2";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-12";
            position = "0,0";
            status = "enable";
          }
        ];
      }
    ];
  };
}
