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
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    specialArgs = { inherit inputs self pkgs; };
  in
  {
    nixosConfigurations = {
      persephone = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          ./hosts/shared
          ./hosts/persephone
          home-manager.nixosModules.home-manager
          {
            home-manager.users.pkraus = import ./home/default.nix {
              inherit pkgs inputs self;
            };
          }
        ];
        specialArgs = specialArgs;
      };
    };

    homeConfigurations.pkraus = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = specialArgs;
      modules = [
        ./home/default.nix
      ];
    };
  };
}