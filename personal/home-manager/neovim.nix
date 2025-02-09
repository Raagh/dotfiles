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
    nixfmt-rfc-style
    cargo
    hub
    unzip

    lua-language-server
    nodejs
    go
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
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${sharedDotfilesPath}/nvim/";
  };

}
