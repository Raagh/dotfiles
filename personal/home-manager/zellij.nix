{
  config,
  pkgs,
  ...
}:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
}
