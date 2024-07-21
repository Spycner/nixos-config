{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit {inputs.nixpkgs.lib} nixosSystem;
    
    specialArgs = {inherit inputs self;};
  in {
    persephone = nixosSystem {
      inherit specialArgs;
      modules = [
        ./persephone
      ];
    };
  }
}
