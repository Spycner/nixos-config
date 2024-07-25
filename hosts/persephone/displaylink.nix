{ pkgs, config, lib, ... }:

let
  displayLinkPkg = pkgs.displaylink.overrideAttrs (oldAttrs: {
    version = "6.0.0-24";
    src = pkgs.fetchzip {
      url = "https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip";
      sha256 = lib.fakeSha256; # Replace this with the actual hash after the first attempt
      name = "displaylink-600.zip";
    };
  });
in
{
  environment.systemPackages = [ displayLinkPkg ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ evdi ];

  boot.kernelModules = [ "evdi" ];
}