{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./wofi.nix
    ./waybar.nix
    ./neovim.nix
    ./terminal.nix
    ./kanshi.nix
    ./swaync.nix
    ./theme.nix
  ];

  home.username = "raagh";
  home.homeDirectory = "/home/raagh";

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    google-chrome
    lazygit
    stow
    kitty

    zathura
    exercism
    # transmission_4-gtk
    vlc
    gnome-calculator
    gnome-text-editor
  ];

  programs.git = {
    enable = true;
    userName = "Raagh";
    userEmail = "pattferraggi@gmail.com";
  };

  #  virtualisation.docker.enable = true;
  #  services.trezord.enable = true;
  #  hardware.keyboard.qmk.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
