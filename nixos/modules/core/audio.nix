{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # jack.enable = true;
    # media-session.enable = true;
  };
}
