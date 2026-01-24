{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}
