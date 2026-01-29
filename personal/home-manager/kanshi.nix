{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Add Kanshi package to user packages
  home.packages = with pkgs; [
    kanshi
  ];

  # Create Kanshi configuration file manually
  home.file.".config/kanshi/config".text = ''
    profile docked-dp12 {
        output DP-12 enable mode 3440x1440 position 0,0 scale 1.0
        output eDP-1 disable
    }

    profile docked-dp11 {
        output DP-11 enable mode 3440x1440 position 0,0 scale 1.0
        output eDP-1 disable
    }

    profile undocked {
        output eDP-1 enable mode 2880x1920 position 0,0 scale 2.0
    }

    profile dual-dp12 {
        output DP-12 enable mode 3440x1440 position 0,0 scale 1.0
        output eDP-1 enable mode 2880x1920 position 3440,0 scale 2.0
    }

    profile dual-dp11 {
        output DP-11 enable mode 3440x1440 position 0,0 scale 1.0
        output eDP-1 enable mode 2880x1920 position 3440,0 scale 2.0
    }
  '';

  # Enable Kanshi as a systemd user service
  systemd.user.services.kanshi = {
    Unit = {
      Description = "Kanshi display configuration daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
