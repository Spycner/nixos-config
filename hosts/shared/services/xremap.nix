{ ... }: {
  services.xremap = {
    # withHypr = true;
    withGnome = true;
    userName = "pkraus";
    config = {
      modmap = [
        {
          name = "caps2esc";
          remap = {
            CapsLock = {
              held = "Control_L";
              alone = "Esc";
              alone_timeout_millis = 200;
            };
          };
        }
      ];
    };
    watch = true;
  };
}
