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
    
    # index-db to find packages faster
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # util to generate catppuccin themes and catppuccinify images
    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # stylix to generate themes and apply them to the system
    stylix.url = "github:danth/stylix";
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
          inputs.stylix.nixosModules.stylix
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