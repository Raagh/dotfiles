{
  config,
  pkgs,
  personalDotfilesPath,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {

      env = [
        "HYPRSHOT_DIR,/home/raagh/Pictures/Screenshots"
        "MUTTER_DEBUG_DISABLE_HW_CURSORS,1"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -no-lazy-grab -show drun";
      "$powermenu" =
        "rofi -show p -modi p:'rofi-power-menu --symbols-font \"JetBrains Mono NF 16\"' -theme-str 'listview {lines: 6;} element-text{spacing:9em;}'";

      exec-once = [
        "nm-applet"
      ];

      monitor = [
        "DP-11,3440x1440@60,0x0,1" # Ultrawide when on DP-11
        "DP-12,3440x1440@60,0x0,1" # Ultrawide when on DP-12
        "eDP-1,2880x1920@120,3440x0,1.5" # Laptop screen positioned to the right
        ",preferred,auto,1" # Any other monitors
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us,es";
        repeat_delay = 250;
        repeat_rate = 30;
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      "$mainMod" = "SUPER";

      # Keybindings
      bind = [
        # Basic binds
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, Escape, exit,"
        "$mainMod, X, exec, $powermenu"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, W, exec, google-chrome-stable"
        "$mainMod, F, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo," # dwindle
        "$mainMod, J, togglesplit," # dwindle
        "$mainMod, R, submap, resize"
        "$mainMod SHIFT, N, exec, swaync-client -t"

        # Move focus with mainMod + hjkl
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Move windows with mainMod + SHIFT + hjkl
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Screenshot binds
        "$mainMod, PRINT, exec, hyprshot -m window"
        "$mainMod SHIFT, PRINT, exec, hyprshot -m region --clipboard-only"

        # Laptop monitor toggle
        "$mainMod, M, exec, ${personalDotfilesPath}/scripts/system/toggle-laptop-monitor.sh"
      ];

      # Volume and brightness binds (repeatable)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, light -A 10"
        ",XF86MonBrightnessDown, exec, light -U 10"
      ];

      # Media control binds (locked)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse binds
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrulev2 = [
        "float, size:800x600, center:1,class:(.protonvpn-app-wrapped)"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "noblur, title:^()$, class:^()$"
      ];
    };

    # Handle resize submap with extraConfig since NixOS doesn't handle submaps well in settings
    extraConfig = ''
      # Resize submap
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };

  # Packages to make hyprland a DE.
  home.packages = with pkgs; [
    blueberry
    networkmanagerapplet
    wdisplays
    nautilus
    pavucontrol
    wl-clipboard
    file-roller
    hyprpolkitagent
    hyprshot
    waypaper
    gnome-system-monitor
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint Electron apps to use Wayland
    HYPRSHOT_DIR = "/home/raagh/Pictures/Screenshots";
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
