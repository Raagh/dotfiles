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
  boot.loader.grub.configurationLimit = 10;
  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "mem_sleep_default=deep" # Change from s2idle to deep for better suspend support
    "amdgpu.ppfeaturemask=0xffffffff" # Enable all power features for better performance
    # "amdgpu.gpu_recovery=1" # Enable GPU recovery for stability
    "amdgpu.runpm=0" # Disable runtime PM for stability (prevents suspend crashes)
    "pcie_aspm=off"

    # Additional parameters to fix hyprlock crashes after suspend
    # "amdgpu.noretry=0" # Allow GPU recovery retries
    # "amdgpu.lockup_timeout=10000" # Increase lockup timeout
  ];

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;
}
