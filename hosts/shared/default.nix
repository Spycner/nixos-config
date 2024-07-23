{ inputs, ... } : {
  imports = [
    ./theming/stylix.nix
    ./hardware/swap.nix
    inputs.stylix.nixosModules.stylix
    inputs.xremap.nixosModules.default
  ];
}
