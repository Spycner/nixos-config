{
  programs.nixvim = {
    plugins = {
      nix = {
        enable = true;
      };
      none-ls = {
        sources = {
          code_actions = {
            statix.enable = true;
          };
          diagnostics = {
            deadnix.enable = true;
            statix.enable = true;
          };
          formatting.alejandra.enable = true;
        };
      };
    };
  };
}