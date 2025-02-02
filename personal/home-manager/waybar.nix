{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        width = 1250;
        margin-top = 8;
        spacing = 8;
        "modules-left" = [
          "custom/logo"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        "modules-center" = [
          "clock"
        ];
        "modules-right" = [
          "group/audio"
          "tray"
          "hyprland/language"
          "battery"
          "group/power"
        ];

        "custom/logo" = {
          format = "";
          tooltip = false;
          on-click = "pidof wofi || wofi --show drun";
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
          format = "<span  weight='bold' >{class}</span>";
          max-length = 120;
          icon = false;
          icon-size = 13;
          separate-outputs = true;
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

        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "custom/power" # First element is the "group leader" and won't ever be hidden
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/quit" = {
          format = "";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };

        "custom/lock" = {
          format = "󰌾";
          tooltip = false;
          on-click = "swaylock";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          on-click = "reboot";
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "shutdown now";
        };

        "group/audio" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 600;
            children-class = "not-power";
            transition-to-left = true;
            click-to-reveal = false;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
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

        "pulseaudio/slider" = {
          min = 5;
          max = 100;
          rotate = 0;
          device = "pulseaudio";
          "scroll-step" = 1;
        };

        "hyprland/language" = {
          format = "   {}";
        };

        clock = {
          format = "󰃭  {:%A, %d %B  %I:%M %p}";
          format-alt = "{%I:%M %p}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        tray = {
          show-passive-items = true;
          icon-size = 20;
          spacing = 5;
        };
      };
    };
    style = ''
      * {
        font-family: DejaVu Serif;
        font-size: 12px;
        font-weight: bold;
        border-radius: 8px;
      }

      #custom-logo {
        font-size: 18px;
        margin-left: 7px;
        margin-right: 12px;
        font-family: Iosevka Nerd Font;
      }

      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power {
        border-radius: 8px;
        margin-left: 7px;
        margin-right: 12px;
        font-size: 18px;
      }

      #pulseaudio-slider trough {
        min-width: 90px;
        min-height: 10px;
        border-radius: 8px;
        background: #343434;
      }
    '';
  };
}
