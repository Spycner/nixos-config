{config, ...}: let
  data = config.xdg.dataHome;
  cond = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./neovim
  ];

  home.sessionVariables = {
    EDITOR = "nivm";
    NIX_AUTO_RUN = "1";
  };
}
