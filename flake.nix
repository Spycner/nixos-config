{
  description = "My NixOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv";

    agenix = {
      url = "github:ryan4yin/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nipkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    systems,
    ... 
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in{
    inherit lib;

    # devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = ForEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      persephone = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/persephone
          ({ pkgs, ... }: {
            environment.systemPackages = [
              (import ./shellscripts/cursor.nix { inherit pkgs; })
            ];
          })
        ];
        specialArgs = {
                inherit inputs outputs;
        };
      };
    };
  };
}