{ pkgs, ... }: {
  home.packages = with pkgs; [
    exiftool
    ffmpegthumbnailer
    unar
    poppler
    fd
  ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_case_sensitive = false;
        sort_reverse = false;
        sort_dirs_first = true;
        linemode = "none";

      };
      preview = {
        max_width = 600;
        max_height = 900;
      };
    };
  };
}