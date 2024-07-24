{ pkgs, ... }: let 
  cursor = pkgs.callPackage ../../../packages/cursor.nix {};
in {
  home.packages = with pkgs; [
    cursor
  ];

  imports = [
    ./vscode.nix
  ];
}