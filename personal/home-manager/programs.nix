{
  pkgs,
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

    vlc
    gnome-disk-utility
    gnome-calculator
    gnome-text-editor
    loupe
    papers

    exercism
    transmission_4-gtk
    portfolio
    protonvpn-gui
    trezor-suite
    framework-tool-tui
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Raagh";
        email = "pattferraggi@gmail.com";
      };
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "google-chrome.desktop" ];
      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "x-scheme-handler/about" = [ "google-chrome.desktop" ];
      "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];

      "application/pdf" = [ "org.gnome.Papers.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
    };

    associations.added = {
      "application/pdf" = [ "org.gnome.Papers.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
    };
  };
}
