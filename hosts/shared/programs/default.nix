{
  imports = [
    ./fonts.nix
    ./gnome.nix
    # ./hyprland.nix
    ./virtualization.nix
    ./xdg.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;

    seahorse.enable = true;
    
    # enable dynamically linked binaries for python etc.
    nix-ld.enable = true;
  };
  
}