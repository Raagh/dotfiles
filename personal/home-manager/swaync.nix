{
  config,
  pkgs,
  ...
}:

{
  services.swaync = {
    enable = true;
    settings = {
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      fit-to-screen = false;
    };
  };
}
