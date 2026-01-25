{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  username = "pete";
in {
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/syncthing";
    openDefaultPorts = true;
  };
}
