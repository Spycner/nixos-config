{
  programs.nixvim = {
    plugins = {
      none-ls = {
        enable = true;
        settings = {
          update_in_insert = true;
        };
      };
    };
  };
}