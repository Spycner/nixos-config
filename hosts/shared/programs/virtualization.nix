{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon.settings = {
      # enables pulling using containerd, which supports restarting from a partial pull
      # https://docs.docker.com/storage/containerd/
      "features" = {"containerd-snapshotter" = true;};
    };
  };
}