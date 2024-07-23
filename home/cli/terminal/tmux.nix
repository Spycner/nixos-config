{
  programs.tmux = {
    enable = true;
    baseIndex = 1;

    extraConfig = ''
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-yank'

      set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
      set -g @catppuccin_flavour 'frappe'

      set -g @plugin 'christmoomey/vim-tmux-navigator'
      bind -n M-H previous-window # alt-shift-h
      bind -n M-L next-window # alt-shift-l
      
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
