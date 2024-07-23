{ inputs, ... } : {
  imports = [
    ./theming/stylix.nix
    ./hardware/swap.nix
    ./services/xremap.nix
    inputs.stylix.nixosModules.stylix
    inputs.xremap.nixosModules.default
  ];
}
