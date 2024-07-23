{ ... }:
{
  imports = [
    ./neovim
    ./shell
    ./terminal
  ];

  home.sessionVariables = {
    EDITOR = "nivm";
    VISUAL = "nvim";
    NIX_AUTO_RUN = "1";
  };
}
