{
  config,
  pkgs,
  pkgsUnstable,
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
    imagemagick
    ghostscript

    lua-language-server
    nodejs
    go
    statix

    lsof
  ];

  programs.opencode = {
    enable = true;
    package = pkgsUnstable.opencode;
    settings = {
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
      };
    };
  };

  # link the neovim config to the .config folder in home
  home.file = {
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink "${sharedDotfilesPath}/nvim/";
  };
}
