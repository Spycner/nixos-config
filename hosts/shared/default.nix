{ inputs, ... } : {
  imports = [
    ./hardware/swap.nix
    ./services/xremap.nix
    inputs.xremap.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;
}