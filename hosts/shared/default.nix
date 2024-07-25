{ inputs, pkgs, ... }: {
  imports = [
    ./core
    ./hardware
    ./nix
    ./programs
    ./services
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.05";
}