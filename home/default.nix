{
  self,
  inputs,
  ...
}: let
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    # laptop
    "pkraus@persephone" = [
      ./base.nix
      ./persephone.nix
    ];

    # desktop
    "pkraus@athena" = [
      ./base.nix
      ./athena.nix
    ];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  system = "x86_64-linux";

  pkgs = inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "pkraus_athena" = homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
	modules = homeImports."pkraus@athena";
      };

      "pkraus_persephone" = homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
	modules = homeImports."pkraus@persephone";
      };
    };
  };
}
