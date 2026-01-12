{
  config,
  pkgs,
  sharedDotfilesPath,
  ...
}:

{
  imports = [ ];

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

    lua-language-server
    nodejs
    go
    statix
  ];

  # link the neovim config to the .config folder in home
  home.file = {
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${sharedDotfilesPath}/nvim/";
  };
}
