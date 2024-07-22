{ pkgs, ... }: {
  home.packages = with pkgs; [
    docker-compose
    rye
    vscode
  ];

  imports = [
    ./neovim
  ];
}
