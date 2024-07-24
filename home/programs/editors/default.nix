{ pkgs, ... }: let 
  cursor = pkgs.callPackage ../../../packages/cursor.nix {};
in {
  home.packages = [
    cursor
  ];

  imports = [
    # ./vscode.nix
  ];
}
