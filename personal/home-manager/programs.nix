{
  pkgs,
  pkgsUnstable,
  ...
}:

let
  portfolio = pkgs.symlinkJoin {
    name = "portfolio";
    paths = [ pkgsUnstable.portfolio ];
    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/portfolio" \
      --set GDK_BACKEND x11
    '';
  };

  frameworkIcon = pkgs.writeText "framework.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32.808 32.808">
      <rect width="32.808" height="32.808" rx="6" fill="#1f1f1f"/>
      <g transform="translate(4 4) scale(.83)" fill="#fff">
        <path d="m29.836 11.164-2.2831-1.354c-1.0689-.6361-1.7296-1.8088-1.7296-3.0775v-2.7079c0-.55437-.2456-1.0768-.6642-1.425-1.2453-1.0341-2.6463-1.8728-4.1614-2.4733-.5051-.199-1.0689-.15991-1.5359.11727l-2.2865 1.3575c-1.0689.63611-2.3869.63611-3.4592 0L11.4294.2441c-.467-.27718-1.0343-.31983-1.5359-.11727-1.5186.60057-2.9161 1.4392-4.158 2.4698-.41856.34825-.66416.87064-.66416 1.425v2.7079c0 1.2686-.65725 2.4414-1.7296 3.0775L1.1286 11.161c-.467.2772-.78524.757-.86826 1.3042-.12799.8067-.19026 1.6312-.19026 2.4698 0 .8387.062266 1.6631.1868 2.4662.083021.5473.40127 1.0306.86826 1.3078l2.2831 1.3539c1.0689.6361 1.7296 1.8088 1.7296 3.0775v2.7079c0 .5543.2456 1.0767.66416 1.425 1.2419 1.0305 2.6428 1.8692 4.158 2.4698.50503.199 1.0689.1599 1.5359-.1173l2.2865-1.3575c1.0689-.6361 2.3868-.6361 3.4592 0l2.2865 1.3575c.467.2772 1.0343.3163 1.5359.1173 1.5152-.6006 2.9161-1.4393 4.158-2.4698.4186-.3483.6642-.8707.6642-1.425v-2.7079c0-1.2687.6607-2.4414 1.7296-3.0775l2.283-1.3539c.467-.2772.7853-.7569.8683-1.3078.1211-.8031.1868-1.6275.1868-2.4662 0-.8386-.0623-1.6631-.1868-2.4662-.0796-.5473-.3944-1.027-.8613-1.3042zM15.446 24.469c-5.1231 0-9.2776-4.268-9.2776-9.5309 0-5.263 4.1545-9.5309 9.2776-9.5309 5.123 0 9.2775 4.2679 9.2775 9.5309 0 5.2629-4.1545 9.5309-9.2775 9.5309z"/>
      </g>
    </svg>
  '';

  frameworkToolTuiLauncher = pkgs.writeShellScriptBin "framework-tool-tui-launcher" ''
    exec kitty --class framework-tool-tui --title framework-tool-tui -e bash -lc 'sudo framework-tool-tui'
  '';
in
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    lazygit
    kitty
    rclone

    vlc
    gnome-disk-utility
    gnome-calculator
    gnome-text-editor
    loupe
    papers

    exercism
    transmission_4-gtk
    portfolio
    proton-vpn
    lutris
    wineWow64Packages.stable
    winetricks
    protonup-qt
    trezor-suite
    framework-tool
    framework-tool-tui
    frameworkToolTuiLauncher
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--enable-unsafe-webgpu"
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
      "x-scheme-handler/file" = [ "org.gnome.Nautilus.desktop" ];
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      "application/pdf" = [ "org.gnome.Papers.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
    };

    associations.added = {
      "x-scheme-handler/file" = [ "org.gnome.Nautilus.desktop" ];
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "application/pdf" = [ "org.gnome.Papers.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "text/plain" = [ "org.gnome.TextEditor.desktop" ];
    };
  };

  xdg.desktopEntries.framework-tool-tui = {
    name = "Framework Tool TUI";
    comment = "Launch Framework Tool TUI in Kitty";
    exec = "framework-tool-tui-launcher";
    terminal = false;
    categories = [ "System" ];
    icon = "${frameworkIcon}";
  };
}
