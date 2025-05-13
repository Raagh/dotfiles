{
  config,
  pkgs,
  assetsPath,
  ...
}:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${assetsPath}/Shogoki.png" ];
      wallpaper = [ "DP-7,${assetsPath}/Shogoki.png" ];

      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
}
