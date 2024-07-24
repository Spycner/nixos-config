{ pkgs, ...}: let 
  vim-tmux-navigator = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "vim-tmux-navigator";
    version = "26.05.2024";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-tmux-navigator";
      rev = "5b3c701686fb4e6629c100ed32e827edf8dad01e";
      sha256 = "sha256-o39bbuD0rqTrvkDfagOBG9FeXPj/2GMS2OKYTaH4mU0="; 
    };
  };
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 10000;
    plugins = with pkgs; [
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          bind-key '"' split-window -v -c "#{pane_current_path}"
          bind-key % split-window -h -c "#{pane_current_path}"

          bind -n M-H previous-window
          bind -n M-L next-window

          unbind C-b
          set -g prefix C-Space
          bind C-Space send-prefix

          set -g mouse on
        '';
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'frappe'
        '';
      }
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
  };
}
