{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    shikane
  ];

  services.shikane = {
    enable = true;
    settings = {
      profile = [
        {
          name = "external-monitor-default";
          output = [
            {
              match = "eDP-1";
              enable = false;
            }
            {
              match = "DP-11";
              enable = true;
            }
          ];
        }
        {
          name = "builtin-monitor-only";
          output = [
            {
              match = "eDP-1";
              enable = true;
              scale = 1.5;
            }
          ];
        }
      ];
    };
  };
}
