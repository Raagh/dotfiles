{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts-emoji
    dejavu_fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };

    targets.nixvim.enable = false;
    targets.qt.enable = false;
    # targets.rofi.enable = false;

    #FIXME: it doesnt work, it has to do with hyprpaper
    image = ../../assets/Shogoki.png;

    # opacity = {
    #   desktop = 0.5;
    #   terminal = 0.9;
    # };
  };
}
