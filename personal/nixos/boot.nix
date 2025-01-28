{ config, pkgs, ... }:

{
  imports = [ ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.grub.default = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 42;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];
}
