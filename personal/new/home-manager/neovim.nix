
{ config, pkgs, ... }:

{
  imports = [];

  home.packages = with pkgs; [
    neovim
    nixfmt-rfc-style
    lua-language-server
    gcc
    ripgrep
    fzf
  ];

  # link the neovim config in shared directory to the .config folder in home
  home.file.".config/nvim/" = { source = ../../../shared/nvim; recursive = true; };

}
