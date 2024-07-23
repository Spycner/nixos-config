{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      tpm
      tmux-sensible
      tmux-yank
    ];
    shortcut = "Space";

    extraConfig = ''
      set -g @plugin 'dreamsofcode-io/catppuccin-tmux
      set -g @catppuccin_flavour 'frappe'

      set -g @plugin 'christmoomey/vim-tmux-navigator'
      bind -n M-H previous-window # alt-shift-h
      bind -n M-L next-window # alt-shift-l
      
      bind C-Space send-prefix

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
