{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    overlay.enable = true;
    theme = "catppuccin_mocha";
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "windowtitle"
            "systray"
            "cava"
          ];
          middle = [ "workspaces" ];
          right = [
            "media"
            "clock"
            "hypridle"
            "power"
          ];
        };
      };
    };
  };
}
