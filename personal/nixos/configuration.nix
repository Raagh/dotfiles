# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  inputs,
  pkgs,
  ...
}:

let
  createAutofirmaCert = pkgs.writeShellApplication {
    name = "create-autofirma-cert";
    runtimeInputs = [ pkgs.openssl ];
    text = builtins.readFile "${inputs.autofirma-nix}/nix/autofirma/create-autofirma-cert";
  };

  installAutofirmaChromeCert = pkgs.writeShellApplication {
    name = "install-autofirma-chrome-cert";
    runtimeInputs = [ pkgs.nss.tools ];
    text = ''
      nss_db="/home/raagh/.pki/nssdb"
      mkdir -p "$nss_db"

      if [[ ! -f "$nss_db/cert9.db" ]]; then
        certutil -N --empty-password -d "sql:$nss_db"
      fi

      certutil -D -d "sql:$nss_db" -n "AutoFirma ROOT" 2>/dev/null || true
      certutil -A -d "sql:$nss_db" -n "AutoFirma ROOT" -t "C,," \
        -i /etc/Autofirma/Autofirma_ROOT.cer
    '';
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix
    ./display.nix
    ./gaming.nix
    ./user.nix
    ./theme.nix
  ];

  # Enable networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Enable Hardware
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.Policy = {
      # BlueZ's default reconnect list only contains audio profiles. Include
      # Bluetooth LE HID so input devices such as the MX Master reconnect
      # after a dropped link instead of requiring a new pairing.
      ReconnectUUIDs = builtins.concatStringsSep "," [
        "00001812-0000-1000-8000-00805f9b34fb" # HID over GATT
        "00001112-0000-1000-8000-00805f9b34fb"
        "0000111f-0000-1000-8000-00805f9b34fb"
        "0000110a-0000-1000-8000-00805f9b34fb"
        "0000110b-0000-1000-8000-00805f9b34fb"
      ];
      ReconnectAttempts = 7;
      ReconnectIntervals = "1,2,4,8,16,32,64";
    };
  };
  services.adw-bluetooth.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.sensor.iio.enable = false;

  # Set your time zone.
  # time.timeZone = "America/Argentina/Buenos_Aires";
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  # services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true;
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  programs.autofirma = {
    enable = true;
  };
  programs.configuradorfnmt.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    cups-filters
    cups-browsed
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for nor)
    #media-session.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.extra-substituters = [ "https://nix-community.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    wget
    eza
    bat
    stow
    docker-compose
    brightnessctl
    wsdd # Required by GVfs network discovery; avoids Nautilus cold-start timeouts
    pfetch
  ];

  # Enable zsh as default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # List services that you want to enable:
  services = {
    dbus.enable = true;
    gvfs.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true; # Prevent wrist triggers while typing
        naturalScrolling = false;
        tapping = true;
        tappingDragLock = false;
        accelSpeed = "0.4"; # Moderate sensitivity (range: -1 to 1)
        accelProfile = "adaptive"; # Natural acceleration curve
        clickMethod = "clickfinger"; # Better multi-finger clicking
      };
    };
    fwupd.enable = true;
    # Enable GNOME Keyring for password storage (WiFi, etc.)
    gnome.gnome-keyring.enable = true;
  };

  systemd.services.framework-charge-limit = {
    description = "Set Framework battery charge limit to 80%";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.framework-tool}/bin/framework_tool --charge-limit 80";
    };
  };

  systemd.services.create-autofirma-cert = {
    description = "Create the local certificate used by AutoFirma";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${createAutofirmaCert}/bin/create-autofirma-cert /etc/Autofirma";
      ExecStartPost = "${pkgs.coreutils}/bin/chown raagh:users /etc/Autofirma/autofirma.pfx";
      RemainAfterExit = true;
    };
  };

  systemd.services.autofirma-chrome-cert = {
    description = "Trust the AutoFirma certificate in Google Chrome";
    wantedBy = [ "multi-user.target" ];
    requires = [ "create-autofirma-cert.service" ];
    after = [ "create-autofirma-cert.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "raagh";
      ExecStart = "${installAutofirmaChromeCert}/bin/install-autofirma-chrome-cert";
      RemainAfterExit = true;
    };
  };

  services.udev.packages = with pkgs; [ trezor-udev-rules ];

  systemd.tmpfiles.rules = [
    "d /mnt/google-drive 0755 raagh users - -"
  ];

  virtualisation.docker.enable = true;

  # Enable fingerprint sensor
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = false;
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';

  # Enable GNOME Keyring PAM integration for automatic unlock
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Dont suspend laptop when lid is off and power is connected
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

  # Enable the bolt protocol for thunderbolt docks
  services.hardware.bolt.enable = true;

  # Fuck you LaLiga!
  networking.extraHosts = ''
    172.67.206.103 assets.moxfield.net
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
