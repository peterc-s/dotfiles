{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
