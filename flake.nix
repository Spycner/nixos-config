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
    catppuccin.url = "github:catppuccin/nix";

    # nix-index-db is used by nix-index to provide a database of packages
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap.url = "github:xremap/nix-flake";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... } @ inputs:
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
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager.users.pkraus = import ./home/default.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "bak";
          }
        ];
        specialArgs = specialArgs;
      };
    };

    homeConfigurations.pkraus = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = specialArgs;
      modules = [
        ./home/default.nix
        catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
