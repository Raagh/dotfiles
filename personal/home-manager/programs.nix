{
  config,
  pkgs,
  inputs,
  ...
}:

let
  portfolio = pkgs.symlinkJoin {
    name = "portfolio";
    paths = [ pkgs.portfolio ];
    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/portfolio" \
      --set GDK_BACKEND x11
    '';
  };
in
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lazygit
    kitty

    exercism
    transmission_4-gtk
    vlc
    gnome-calculator
    gnome-text-editor
    gnome-system-monitor

    portfolio
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Raagh";
    userEmail = "pattferraggi@gmail.com";
  };

  programs.zathura.enable = true;

}
