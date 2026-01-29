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
      wallpaper = [
        "DP-12,${assetsPath}/Shogoki.png" # Ultrawide monitor (via KVM)
        "eDP-1,${assetsPath}/Shogoki.png" # Laptop screen
        ",${assetsPath}/Shogoki.png" # Fallback for any other monitor
      ];

      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
}
