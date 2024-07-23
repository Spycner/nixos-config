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
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs self; };
    homeManagerConfigurations = import ./home { inherit self inputs nixpkgs system; };
  in
  {
    nixosConfigurations = {
      persephone = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/shared
          ./hosts/persephone
          home-manager.nixosModules.home-manager {
            home-manager = {
              users.pkraus = homeManagerConfigurations.homeConfigurations.pkraus;
              extraSpecialArgs = specialArgs;
              backupFileExtension = "bak";
            };
          }
        ];
        specialArgs = specialArgs;
      };
    };

    homeConfigurations = homeManagerConfigurations.homeConfigurations;
  };
}