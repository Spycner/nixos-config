{ pkgs, ... }: let
  ZINIT_HOME = "$HOME/.local/share/zinit/zinit.git";
in 
{
  home.packages = with pkgs; [
    zinit
    vivid
    fzf
    ripgrep
    curl
    wget
  ];

  home.sessionVariables = {
    ZINIT_HOME = ZINIT_HOME;
    HISTSIZE = 10000;
    SAVEHIST = 10000;
    
    LS_COLORS = "$(vivid generate catppuccin-frappe)";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";

    LESSHISTFILE = "$HOME/.cache/less/history";
    LESSKEY = "$HOME/.config/less/lesskey";
  };

  programs.starship = {
    enable = true;
    settings = {
      # Sets user-defined palette
      palette = "catppuccin_frappe";

      character = {
        success_symbol = "[[♥](bold green) ❯](bold maroon)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold green)";
      };

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };

      palettes.catppuccin_frappe = {
        rosewater = "#f2d5cf";
        flamingo = "#eebebe";
        pink = "#f4b8e4";
        mauve = "#ca9ee6";
        red = "#e78284";
        maroon = "#ea999c";
        peach = "#ef9f76";
        yellow = "#e5c890";
        green = "#a6d189";
        teal = "#81c8be";
        sky = "#99d1db";
        sapphire = "#85c1dc";
        blue = "#8caaee";
        lavender = "#babbf1";
        text = "#c6d0f5";
        subtext1 = "#b5bfe2";
        subtext0 = "#a5adce";
        overlay2 = "#949cbb";
        overlay1 = "#838ba7";
        overlay0 = "#737994";
        surface2 = "#626880";
        surface1 = "#51576d";
        surface0 = "#414559";
        base = "#303446";
        mantle = "#292c3c";
        crust = "#232634";
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Catppuccin Frappe";
    };
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

      # Add Catppuccin theme for Fast Syntax Highlighting
      CATPPUCCIN_FLAVOUR="frappe"  # Change this to your preferred flavor: latte, frappe, macchiato, or mocha
      CATPPUCCIN_FSH_THEME="$HOME/.config/fsh/catppuccin-$CATPPUCCIN_FLAVOUR.ini"

      if [ ! -f "$CATPPUCCIN_FSH_THEME" ]; then
        mkdir -p "$(dirname "$CATPPUCCIN_FSH_THEME")"
        curl -o "$CATPPUCCIN_FSH_THEME" "https://raw.githubusercontent.com/catppuccin/zsh-fsh/main/themes/catppuccin-$CATPPUCCIN_FLAVOUR.ini"
      fi

      # Apply the theme after loading fast-syntax-highlighting
      zinit light zdharma-continuum/fast-syntax-highlighting
      fast-theme XDG:catppuccin-$CATPPUCCIN_FLAVOUR

      # Download Catppuccin Frappe theme for bat
      BAT_THEME_DIR="$(bat --config-dir)/themes"
      mkdir -p "$BAT_THEME_DIR"
      if [ ! -f "$BAT_THEME_DIR/Catppuccin Frappe.tmTheme" ]; then
        wget -P "$BAT_THEME_DIR" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
      fi
    '';
  };

  programs.eza = {
    enable = true;
    icons = true;
    git = true;
  };
}
