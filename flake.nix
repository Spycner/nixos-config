{
  description = "My NixOS system flake";

  inputs = {
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url =  "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccinifier = {
      url = "github:lighttigerXIV/catppuccinifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./home
        ./hosts
        inputs.devenv.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = {
        inputs',
        config,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;

        pre-commit = {
          settings.excludes = [ "flake.lock" ];

          settings.hooks = {
            alejandra.enable = true;
            prettier = {
              enable = true;
            };
          };
        };

        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            ruff.enable = true;
            deadnix.enable = true;
            spellcheck.enable = true;
            shfmt = {
              enable = true;
              ident_size = 4;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            inputs'.agenix.packages.default
            inputs'.catppuccinifier.packages.cli
            config.treefmt.build.wrapper
            config.packages.repl
            nil
            git
            alejandra
            nodePackages.prettier
            glow
            statix
            deadnix
          ];
          name = "dots";
          DIRENV_LOG_FORMAT = "";
          shellHooks = ''
            ${config.pre-commit.installationScript}
          '';
          languages.nix.enable = true;
        };
      };
    };
}
