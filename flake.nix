{
  description = "My NixOS system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-index-db is used by nix-index to provide a database of packages
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    xremap.url = "github:xremap/nix-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
  in
  {
    nixosConfigurations = {
      persephone = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/shared
          ./hosts/persephone
          home-manager.nixosModules.home-manager
          {
            home-manager.users.pkraus = import ./home/default.nix {
              inherit inputs;
            };
          }
        ];
        specialArgs = specialArgs;
      };
    };

    homeConfigurations.pkraus = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = specialArgs;
      modules = [
        ./home/default.nix
      ];
    };
  };
}
