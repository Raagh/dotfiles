{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lazygit
    stow
    kitty

    exercism
    transmission_4-gtk
    vlc
    gnome-calculator
    gnome-text-editor
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
