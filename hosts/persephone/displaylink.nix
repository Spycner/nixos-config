{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    displaylink
    evdi
  ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    evdi
  ];

  boot.kernelModules = [ "evdi" ];

  hardware.displaylink.enable = true;
}