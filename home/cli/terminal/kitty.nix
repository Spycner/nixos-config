{ pkgs, ... }:{
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      package = pkgs.nerdfont.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
  };
}
