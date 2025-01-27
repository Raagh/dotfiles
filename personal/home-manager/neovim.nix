{ config, pkgs, ... }:

{
  imports = [ ];

  home.packages = with pkgs; [
    neovim
    nixfmt-rfc-style
    lua-language-server
    gcc
    ripgrep
    fzf
  ];

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];

  # link the neovim config to the .config folder in home
  home.file = {
    ".config/nvim/".source =
      config.lib.file.mkOutOfStoreSymlink "/home/raagh/Code/dotfiles/shared/nvim/";
  };

}
