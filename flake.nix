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

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
    specialArgs = {inherit inputs self;};
  in  {
    nixosConfigurations = {
      persephone = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./home
          ./hosts/shared
          ./hosts/persephone
          inputs.home-manager.nixosModules.home-manager {
            home-manager = {
              users.pkraus.imports = homeImports."pkraus@persephone";
              extraSpecialArgs = specialArgs;
              backupFileExtension = "bak";
            };
          }
        ];
      };
    };
  };
}
