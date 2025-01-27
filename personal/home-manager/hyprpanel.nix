{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  home.packages = with pkgs; [
    hyprpanel
  ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;
    theme = "rose_pine_vivid";
    settings = {
      bar.launcher.icon = "";
      menus.dashboard.shortcuts.left.shortcut1.command = "google-chrome-stable";
      menus.dashboard.shortcuts.left.shortcut1.icon = "󰊯";
      menus.dashboard.shortcuts.left.shortcut1.tooltip = "Google Chrome";
      menus.dashboard.shortcuts.left.shortcut4.command = "~/.config/rofi/bin/launcher";
      theme = {
        bar.menus.menu.battery.scaling = 85;
        bar.menus.menu.bluetooth.scaling = 85;
        bar.menus.menu.clock.scaling = 65;
        bar.menus.menu.dashboard.confirmation_scaling = 75;
        bar.menus.menu.dashboard.scaling = 75;
        bar.menus.menu.media.scaling = 85;
        bar.menus.menu.network.scaling = 85;
        # bar.menus.menu.calendar.scaling = 85;
        bar.menus.menu.notifications.scaling = 85;
        bar.menus.menu.power.scaling = 85;
        bar.menus.menu.volume.scaling = 85;
        bar.menus.popover.scaling = 85;
        bar.scaling = 75;

        notification.scaling = 85;
        osd.scaling = 85;
        tooltip.scaling = 85;
      };
    };
  };
}
