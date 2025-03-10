# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  imports =
    [ # Include the results of the hardware scan.
      ./displaylink.nix
      ./hardware-configuration.nix
    ];

  networking.hostName = "persephone";

  services.xserver = {
    xkb.layout = "de";
  };

  console.keyMap = "de";
}
