{ config, pkgs, ... }:

{
  imports = [ ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  fonts.fontconfig.enable = true;
  home.packages = [
    # noto-fonts-emoji
    # dejavu_fonts
    # liberation_ttf
    # source-code-pro
    # inter
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
