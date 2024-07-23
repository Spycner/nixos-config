{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./keymaps.nix
    ./options.nix
    ./plugins
    ./theme.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
  };
}