{
  description = "Raagh NixOS setup";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-25.11";
  };
  outputs =
    inputs@{
      nixos-hardware,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      ...
    }:
    let
      assetsPath = "/home/raagh/Code/dotfiles/assets";
      personalDotfilesPath = "/home/raagh/Code/dotfiles/personal";
      sharedDotfilesPath = "/home/raagh/Code/dotfiles/shared";

      system = "x86_64-linux";

      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit pkgsUnstable;
          inherit personalDotfilesPath;
          inherit sharedDotfilesPath;
          inherit assetsPath;
          inherit inputs;
        };
        modules = [
          nixos-hardware.nixosModules.framework-amd-ai-300-series
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.raagh = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              inherit pkgsUnstable;
              inherit personalDotfilesPath;
              inherit sharedDotfilesPath;
              inherit assetsPath;
              inherit inputs;
            };
          }

          stylix.nixosModules.stylix
        ];
      };
    };
}
