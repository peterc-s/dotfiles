{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev"; # disko handles
  };
}
