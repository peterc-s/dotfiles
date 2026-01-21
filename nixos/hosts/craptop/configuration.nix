{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  hostName = "craptop";
in {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  # touchpad support
  services.libinput.enable = true;

  # users - TODO: i feel like this should be modularise differently to how other things are
  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [];

  system.stateVersion = "25.11"; # don't change without looking up
}
