{...}: {
  imports = [
    ./gnome.nix
    # ./greetd.nix only if hyprland is enabled
    ./pipewire.nix
    ./printing.nix
    ./xremap.nix
  ];

  services = {
    # D-Bus (Desktop Bus) configuration
    # The broker implementation offers improved performance and security
    # compared to the traditional daemon-based model
    dbus.implementation = "broker";

    # Profile-sync-daemon (PSD) configuration
    # PSD improves browser performance by syncing browser profiles to RAM
    psd = {
      enable = true;  # Activates PSD on the system
      resyncTimer = "10m";  # Sets the resync interval to 10 minutes
      # This balances performance gains with data safety by periodically
      # syncing changes back to disk
    };
  };
}