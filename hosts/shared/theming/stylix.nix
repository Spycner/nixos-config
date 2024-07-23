{ pkgs, ... }:
let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  wallpaper = ./shaded_landscape.png;
in
{
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = theme;
    image = wallpaper;

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.catppuccin-cursors.frappeLight;
      name = "catppuccin-frappe-light-cursors";
    };
  };
}
