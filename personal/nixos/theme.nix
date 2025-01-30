{ config, pkgs, ... }:

{
  stylix = {

    # Here I set it so grub and gdm follow that theme too.
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    #FIXME: it doesnt work, it has to do with hyprpaper
    image = ../../assets/Shogoki.png;
  };
}
