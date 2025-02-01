{
  description = "Raagh NixOS setup";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-24.11";
  };
  outputs =
    inputs@{
      nixos-hardware,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      assets = "/home/raagh/Code/dotfiles/assets/";
      personalDotfilesPath = "/home/raagh/Code/dotfiles/personal/";
      sharedDotfilesPath = "/home/raagh/Code/dotfiles/shared/";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit personalDotfilesPath;
          inherit sharedDotfilesPath;
          inherit inputs;
        };
        modules = [
          nixos-hardware.nixosModules.dell-xps-13-9310
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.raagh = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = {
              inherit personalDotfilesPath;
              inherit sharedDotfilesPath;
              inherit inputs;
            };
          }

          stylix.nixosModules.stylix
        ];
      };
    };
}
