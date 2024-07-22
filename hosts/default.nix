{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self;};
  in {
    persephone = nixosSystem {
      inherit specialArgs;
      modules = [
        ./persephone
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            user.pkraus.imports = homeImports."pkraus@persephone";
            extraSpecialArgs = specialArgs;
            backupFileExtension = "bak";
          };
        }
        inputs.agenix.nixosModules.default
      ];
    };
  };
}
