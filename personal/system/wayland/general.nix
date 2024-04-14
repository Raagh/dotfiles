{ config, pkgs, ...}:
{
  users.users.raagh.extraGroups = [ "video" ];
  programs.light.enable = true;
}
