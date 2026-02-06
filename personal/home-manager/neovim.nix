{
  config,
  pkgs,
  pkgsUnstable,
  sharedDotfilesPath,
  ...
}:

{
  imports = [ ./opencode ];

  home.packages = with pkgs; [
    neovim
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
