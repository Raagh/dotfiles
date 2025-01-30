{ config, pkgs, ... }:

{
  stylix = {

    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    #FIXME: it doesnt work, it has to do with hyprpaper
    image = ../../assets/Shogoki.png;
  };
}
