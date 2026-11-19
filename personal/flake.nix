{
  description = "Raagh NixOS setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-26.05";

    autofirma-nix = {
      url = "github:nix-community/autofirma-nix";
    };
  };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
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
          inputs.autofirma-nix.nixosModules.autofirma
          inputs.autofirma-nix.nixosModules.configuradorfnmt
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupCommand = "hm-backup";
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
