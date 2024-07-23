{ inputs, ... } : {
  imports = [
    ./theming/stylix.nix
    ./hardware/swap.nix
    ./hardware/xremap.nix
    inputs.stylix.nixosModules.stylix
    inputs.xremap.nixosModules.default
  ];
}
