{ config, pkgs, ... }:

{
  # base00: "#191724"
  # base01: "#1f1d2e"
  # base02: "#26233a"
  # base03: "#6e6a86"
  # base04: "#908caa"
  # base05: "#e0def4"
  # base06: "#e0def4"
  # base07: "#524f67"
  # base08: "#eb6f92"
  # base09: "#f6c177"
  # base0A: "#ebbcba"
  # base0B: "#31748f"
  # base0C: "#9ccfd8"
  # base0D: "#c4a7e7"
  # base0E: "#f6c177"
  # base0F: "#524f67"

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        width = 1250;
        height = 40;
        margin-top = 8;
        spacing = 0;
        "modules-left" = [
          "custom/logo"
          "hyprland/workspaces"
          "hyprland/window"
          "hyprland/submap"
        ];
        "modules-center" = [
          "clock"
        ];
        "modules-right" = [
          "tray"
          "group/audio"
          "hyprland/language"
          "battery"
          "group/power"
        ];

        "custom/logo" = {
          format = "";
          tooltip = false;
          on-click = "pidof rofi || rofi -no-lazy-grab -show drun";
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
        };

        "hyprland/window" = {
          format = "<span  weight='bold' >{class}</span>";
          max-length = 120;
          icon = false;
          separate-outputs = true;
        };

        "hyprland/submap" = {
          format = "[{}]";
          max-length = 8;
          tooltip = false;
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
          locale = "en_US.UTF-8";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#${config.lib.stylix.colors.base0A}'><b>{}</b></span>";
              "weekdays" = "<span color='#${config.lib.stylix.colors.base0E}'><b>{}</b></span>";
              "today" = "<span color='#${config.lib.stylix.colors.base08}'><b>{}</b></span>";
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
        font-size: 12px;
        font-weight: bold;
        border-radius: 8px;
      }

      #workspaces button {
        padding: 2px 4px 2px 0px;
      }

      #workspaces button label {
        color: #${config.lib.stylix.colors.base0A};
      }

      #workspaces button.active label {
        color: #${config.lib.stylix.colors.base0B};
      }

      #custom-logo {
        font-size: 18px;
        margin-left: 7px;
        margin-right: 12px;
      }

      #clock {
        color: #${config.lib.stylix.colors.base08};
      }

      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power {
        margin-left: 7px;
        margin-right: 12px;
        font-size: 18px;
      }

      #submap {
        color: #${config.lib.stylix.colors.base08};
      }

      #pulseaudio-slider trough {
        min-width: 90px;
        min-height: 10px;
      }

      .modules-left #workspaces button {
        border-bottom: 1px solid transparent;
      }
      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active {
        border-bottom: 1px solid transparent;
      } 

      #battery {
        color: #${config.lib.stylix.colors.base09};
      }

      #pulseaudio {
        color: #${config.lib.stylix.colors.base0D};
      }

      #language {
        color: #${config.lib.stylix.colors.base0A};
      }
    '';
  };
}
