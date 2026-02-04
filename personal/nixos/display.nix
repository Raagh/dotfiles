{ config, pkgs, ... }:

{
  imports = [ ];

  # Color management
  services.colord.enable = true;

  # Graphics and color management (AMD-specific, essential)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # AMD Mesa drivers (includes RADV Vulkan driver by default)
      mesa

      # VA-API acceleration for AMD
      libva-vdpau-driver # VA-API to VDPAU bridge
      libvdpau-va-gl # VDPAU to OpenGL bridge
    ];
  };

  # Enable proper font rendering for better display quality
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel.rgba = "rgb";
    };
  };
}
