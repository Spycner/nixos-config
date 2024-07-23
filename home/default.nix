{ self, inputs, nixpkgs ? inputs.nixpkgs, system ? "x86_64-linux" }:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  extraSpecialArgs = { inherit inputs self; };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  homeConfigurations."pkraus" = homeManagerConfiguration {
    inherit pkgs extraSpecialArgs;
    modules = [
      ({ lib, ... }: {
        imports = [
          inputs.nix-index-db.hmModules.nix-index
          ./cli
          ./engineering
        ];

        home = {
          username = "pkraus";
          homeDirectory = "/home/pkraus";
          stateVersion = "24.05";
          extraOutputsToInstall = ["doc" "devdoc"];
        };

        manual = {
          html.enable = true;
          json.enable = true;
          manpages.enable = true;
        };

        programs.home-manager.enable = true;
      })
    ];
  };
}