{ inputs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = "pkraus";
    homeDirectory = "/home/pkraus";
    stateVersion = "24.05";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };

  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./cli
    ./programs
  ];
}
