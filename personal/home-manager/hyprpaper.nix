{
  config,
  pkgs,
  assetsPath,
  ...
}:

{
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
