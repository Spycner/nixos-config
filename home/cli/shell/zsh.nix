{ pkgs, ... }: let
  ZINIT_HOME = "$HOME/.local/share/zinit/zinit.git";
in 
{
  home.packages = with pkgs; [
    zinit
    eza
    bat
    vivid
    fzf
    ripgrep
  ];

  home.sessionVariables = {
    ZINIT_HOME = ZINIT_HOME;
    HISTSIZE = 10000;
    SAVEHIST = 10000;
    LS_COLORS = "$(vivid generate catppuccin-frappe)";
    BAT_THEME = "Catppuccin Frappe";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      ld = "eza -LD";
      lf = "eza -lf";
      lh = "eza -dl .* --group-directories-first";
      ll = "eza -al --group-directories-first";
      ls = "eza -alf --color=always --sort=size | grep -v /";
      lt = "eza -alT";

      shutdown = "sudo shutdown now";
      restart = "sudo reboot";

      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";

      cat = "bat";
      bathelp = "bat --plain --language=help";
      batl = "bat --paging=never -l log";

      grep = "grep -P -i --color=auto";

      gitundo = "git reset --soft HEAD^";

      cleanup = "sudo nix-collect-garbage";
      flake = "sudo nixos-rebuild switch --flake";
    };

    initExtra = ''
      bindkey -e
      bindkey "^p" history-search-backward
      bindkey "^n" history-search-forward

      if [ ! -d "$ZINIT_HOME" ]; then
      mkdir -p "$(dirname $ZINIT_HOME)"
      git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      fi

      source "${ZINIT_HOME}/zinit.zsh"

      # plugins #

      zinit light zdharma-continuum/fast-syntax-highlighting
      zinit light zsh-users/zsh-completions # get possible completions for command i.e. go -> tab
      zinit light zsh-users/zsh-autosuggestions # autosuggest based on history

      zinit snippet OMZP::sudo
      zinit snippet OMZP::command-not-found
      zinit snippet OMZP::tmux

# load completions
      autoload -U compinit && compinit
      zinit cdreplay -q

      zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z }"
      zstyle ":completion:*" menu no

      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups
    '';
  };
}
