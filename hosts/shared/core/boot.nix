{ lib, config, pkgs, ...}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
        consoleMode = lib.mkDefault "max";
      };
    };

    plymouth = {
      enable = true;
      font = "${pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Medium.ttf";
    };
  };

  environment.systemPackages = [
    config.boot.kernelPackages.cpupower
  ];
}
