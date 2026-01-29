{
  config,
  pkgs,
  ...
}:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      # Laptop only - when no external monitors are connected
      {
        profile.name = "laptop-only";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            status = "enable";
            scale = 2.0;
          }
        ];
      }

      # Ultrawide monitor - using EDID info so it works regardless of DP port
      {
        profile.name = "ultrawide";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            # Using make/model/serial instead of port name for KVM stability
            criteria = "Microstep MAG342CQRV DB6H230900581";
            position = "0,0";
            status = "enable";
            mode = "3440x1440@59.99900";
          }
        ];
      }
    ];
  };
}
