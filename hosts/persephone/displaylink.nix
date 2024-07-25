{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [ displaylink ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ evdi ];

  boot.kernelModules = [ "evdi" ];
}