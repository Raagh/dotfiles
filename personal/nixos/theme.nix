{ config, pkgs, ... }:

{
  stylix = {

    # Here I set it so grub and gdm follow that theme too.

    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
