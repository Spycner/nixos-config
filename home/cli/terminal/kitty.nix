{ pkgs, ... }:{
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    theme = "Catppuccin-Frappe";
  };
}
