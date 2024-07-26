{ pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    lazygit
  ];

  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    lfs.enable = true;

    extraConfig = {
      gpg.format = "ssh";
      credential = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
        useHttpPath = true;
      };
    };
    userEmail = "pascal98kraus@gmail.com";
    userName = "Spycner";
  };
}