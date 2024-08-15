{
  pkgs,
  config
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
        "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
        "MOZ_WEBRENDER,1"
        # misc
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland"
      ]
    };
    extraConfig = builtins.readFile ./conf/hyprland.conf;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  imports = [
    ./programs/default.nix
  ];

  home.packages = [
    waybar # the status bar
    swaybg # the wallpaper
    swayidle # the idle timeout
    swaylock # locking the screen
    wlogout # logout menu
    wl-clipboard # copying and pasting
    hyprpicker # color picker

    hyprshot # screen shot
    grim # taking screenshots
    slurp # selecting a region to screenshot
    wf-recorder # screen recording

    mako # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    # audio
    alsa-utils # provides amixer/alsamixer/...
    mpd # for playing system sounds
    mpc-cli # command-line mpd client
    ncmpcpp # a mpd client with a UI
    networkmanagerapplet # provide GUI app: nm-connection-editor
  ];

  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
    configFile = {
      "hypr/mako" = {
        source = ./conf/mako;
        recursive = true;
      };
      "hypr/scripts" = {
        source = ./conf/scripts;
        recursive = true;
      };
      "hypr/waybar" = {
        source = ./conf/waybar;
        recursive = true;
      };
      "hypr/wlogout" = {
        source = ./conf/wlogout;
        recursive = true;
      };

      # music player - mpd
      "mpd" = {
        source = ./conf/mpd;1
        recursive = true;
      };
    };
  };

  userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };
}