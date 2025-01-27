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
  };
}
