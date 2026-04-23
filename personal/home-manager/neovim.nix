{
  config,
  pkgs,
  pkgsUnstable,
  sharedDotfilesPath,
  ...
}:

{
  imports = [ ./opencode.nix ];

  home.packages = with pkgs; [
    pkgsUnstable.neovim
    gcc
    ripgrep
    fzf
    fd
    nixfmt-rfc-style
    cargo
    hub
    unzip
    gnumake
    imagemagick
    ghostscript

    lua-language-server
    typescript-go
    nodejs
    go
    statix

    lsof
  ];

  # link the neovim config to the .config folder in home
  home.file = {
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${sharedDotfilesPath}/nvim/";
  };
}
