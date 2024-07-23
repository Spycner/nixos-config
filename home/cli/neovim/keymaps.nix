{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      { mode = "n"; key = "<leader>t"; action = "<CMD>Neotree filesystem toggle left<CR>"; }
      { mode = "n"; key = "-"; action = "<CMD>Oil<CR>"; }
      { mode = "n"; key = "<leader>ff"; action = "<CMD>Telescope find_files<CR>"; }
      { mode = "n"; key = "<leader>fg"; action = "<CMD>Telescope live_grep<CR>"; }
    ];
  };
}