{ config, pkgs, ... }:

{
  stylix.enable = true;

  #FIXME: it doesnt work, it has to do with hyprpaper
  stylix.image = ../assets/Shogoki.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

  # stylix.opacity = {
  #   desktop = 0.5;
  #   terminal = 0.9;
  # };
}
