# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      <nixos-hardware/dell/xps/13-9310>
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Make time compatible for dualbooting Windows
  time.hardwareClockInLocalTime = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "rmx-nix";

  # Enable Some Hardware 
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.utf8";
    LC_IDENTIFICATION = "es_ES.utf8";
    LC_MEASUREMENT = "es_ES.utf8";
    LC_MONETARY = "es_ES.utf8";
    LC_NAME = "es_ES.utf8";
    LC_NUMERIC = "es_ES.utf8";
    LC_PAPER = "es_ES.utf8";
    LC_TELEPHONE = "es_ES.utf8";
    LC_TIME = "es_ES.utf8";
  };

  # Enable the desktop environment.
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager = {
    defaultSession = "none+bspwm";
    setupCommands = ''
      my_laptop_external_monitor=$(${pkgs.xorg.xrandr}/bin/xrandr --query | grep 'DP-1 connected')
      if [[ $my_laptop_external_monitor = *connected* ]]; then
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --primary --mode 3440x1440 --rate 100 --output eDP-1 --off
      else
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1200 --rate 60
      fi
    '';
    lightdm = {
      enable = true;
      greeter.enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

  # Configure coneclole keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      sendEventsMode = "disabled-on-external-mouse";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raagh = {
    isNormalUser = true;
    description = "Raagh";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "raagh";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable zsh as default shell 
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "npm" "vi-mode" ];
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };

  fonts.fonts = with pkgs; [
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    source-code-pro
    inter
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  ];

  # Packages 
  environment.systemPackages = with pkgs; [
    # App Dependencies
    cargo
    gcc
    ripgrep

    # Xorg
    xorg.xbacklight

    # Global Apps
    wget
    google-chrome
    neovim
    sumneko-lua-language-server
    geany
    git
    lazygit
    pfetch
    bat
    exa
    htop
    galculator
    vlc
    stow
    zathura
    portfolio

    # Desktop Environment
    polybar
    alacritty
    sxhkd
    picom
    pavucontrol
    blueberry
    xclip
    rofi
    dunst
    flameshot
    nitrogen
    networkmanagerapplet
    i3lock-color
    arandr
    xfce.xfce4-power-manager

    # Theming
    qogir-theme
    papirus-icon-theme
    rose-pine-gtk-theme

    # Files
    unzip
    ranger
    ueberzug
    udiskie
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];

  nixpkgs.config.packagesOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      jackSupport = true;
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
      iwSupport = true;
      nlSupport = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Trezor Hardware wallet support
  services.trezord.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}