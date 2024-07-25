{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true; # Detect printers via UDP 5353
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };

    # DNS resolver
    resolved.enable = true;
  };
}