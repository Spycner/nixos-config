{ pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    lazygit
  ];

  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    lfs.enable = true;

    extraConfig.gpg.format = "ssh";
    userEmail = "pascal98kraus@gmail.com";
    userName = "Spycner";
  };
}
