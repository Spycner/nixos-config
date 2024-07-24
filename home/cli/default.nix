{ ... }:
{
  imports = [
    ./neovim
    ./programs
    ./shell
    ./terminal
  ];

  home.sessionVariables = {
    EDITOR = "nivm";
    VISUAL = "nvim";
    NIX_AUTO_RUN = "1";
  };
}
