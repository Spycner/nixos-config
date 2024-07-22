{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self;};

    system = "x86_64-linux";
    pkgs = inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    persephone = nixosSystem {
      inherit specialArgs;
      modules = [
        ./persephone
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            users.pkraus.imports = homeImports."pkraus@persephone";
            extraSpecialArgs = specialArgs;
            backupFileExtension = "bak";
          };
        }
        inputs.agenix.nixosModules.default
      ];
    };
  };
}
