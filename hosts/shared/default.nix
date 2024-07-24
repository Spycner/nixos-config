{ inputs, ... } : {
  imports = [
    ./hardware/swap.nix
    ./services/xremap.nix
    inputs.xremap.nixosModules.default
  ];
}
