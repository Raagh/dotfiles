{ config, pkgs, ... }:

{
  stylix = {

    # Here I set it so grub and gdm follow that theme too.

    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    #FIXME: this propery is mandatory in the current version
    # but in future version I will only set this on the home configuration.
    image = ../../assets/Shogoki.png;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
