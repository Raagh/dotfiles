{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        height = 32;
        width = 1250;
        spacing = 4;
        margin-top = 8;
        "modules-center" = [
          "custom/logo"
          "hyprland/workspaces"
          "hyprland/window"
          "memory"
          "battery"
          "pulseaudio"
          "hyprland/language"
          "clock"
          "tray"
        ];

        "custom/logo" = {
          format = "";
          tooltip = false;
          on-click = "pidof wofi || wofi --no-lazy-grab --show drun";
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
            default = "";
          };
          persistent_workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
          };
        };

        "hyprland/window" = {
          max-length = 30;
          separate-outputs = true;
        };

        memory = {
          format = "󰍛   %{percentage}";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
        };

        pulseaudio = {
          scroll-step = 5;
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "muted  ";
          format-icons = {
            headphones = " ";
            handsfree = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = "  ";
            default = [
              " "
              " "
            ];
          };
          on-click = "pavucontrol";
        };

        "hyprland/language" = {
          format = "   {}";
        };

        clock = {
          format = "󰃭  {:%A, %d %B  %I:%M %p}";
          format-alt = "{%I:%M %p}";
        };

        tray = {
          show-passive-items = true;
          icon-size = 20;
          spacing = 5;
        };
      };
    };
    style =

      ''
        * {
          font-family: DejaVu Serif;
          font-size: 12px;
          font-weight: bold;
          border-radius: 8px;
        }

        /*-----module groups----*/
        .modules-center {
          margin: 2px 0 0 0;
        }

        /*-----modules indv----*/
        #workspaces button {
          padding: 2.5px;
        }

        #memory {
          padding: 0 10px 0 500px;
        }
        #custom-logo {
          font-size: 18px;
          margin: 0;
          margin-left: 7px;
          margin-right: 12px;
          padding: 0;
          font-family: Iosevka Nerd Font;
        }

        #tray,

        #clock {
          padding: 0 10px;
        }

        #custom-power {
          border-radius: 100px;
          margin: 5px 5px;
          padding: 1px 1px 1px 6px;
        }
        /*-----Indicators----*/
        #battery {
          padding: 0 10px;
        }

        #pulseaudio {
          padding: 0 10px;
        }

        #language {
          padding: 0 10px;
        }
      '';
  };
}
