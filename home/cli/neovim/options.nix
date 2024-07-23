{ config, ... }: {
  programs.nixvim = {
    clipboard = {
      providers = {
        xclip = {
          enable = true;
        };
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      mousemodel = "extend";
      splitbelow = true;
      splitright = true;

      swapfile = false;

      ignorecase = true;
      smartcase = true;

      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      textwidth = 0;

      undofile = true;
      undodir = "${config.xdg.dataHome}/nvim/undo";
    };
  };
}
