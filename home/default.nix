{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = "pkraus";
    homeDirectory = "/home/pkraus";
    stateVersion = "24.05";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };

  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./cli
    ./engineering
  ];
}