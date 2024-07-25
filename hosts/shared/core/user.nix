{pkgs, ...}: {
  users.users.pkraus = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
      "docker"
      "scanner"
      "lp"
    ];
  };

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = false;
}
