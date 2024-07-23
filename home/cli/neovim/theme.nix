{
  programs.nixvim = {
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "frappe";
          integrations = {
            treesitter = true;
          };
        };
      };
    };
    plugins.lualine = {
      enable = true;
    };
  };
}