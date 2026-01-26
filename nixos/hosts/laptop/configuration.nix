{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  hostName = "laptop";
in {
  imports = [
    ../../generic.nix
    ./disk-config.nix
    ./hardware-configuration.nix

    # bootloader
    ../../modules/boot/grub.nix
    ../../modules/boot/plymouth.nix

    # dm
    ../../modules/display-manager/ly.nix

    # desktop
    ../../modules/desktop/sway.nix
    ../../modules/desktop/niri.nix
    ../../modules/desktop/noctalia-shell.nix

    # common stuff
    ../../modules/core

    # configured software
    ../../modules/sw/fish.nix
    ../../modules/sw/git.nix
    ../../modules/sw/librewolf.nix
    ../../modules/sw/mullvad.nix
    ../../modules/sw/neovim.nix
    ../../modules/sw/syncthing.nix
    ../../modules/sw/vesktop.nix

    # features
    ../../modules/features/bluetooth.nix
    ../../modules/features/common-software.nix
    ../../modules/features/cyber.nix # must be disabled on install due to binary-ninja
    ../../modules/features/dark-mode.nix
    ../../modules/features/development.nix
    ../../modules/features/fprint.nix
    ../../modules/features/gaming.nix
    ../../modules/features/power.nix
    ../../modules/features/silly.nix
    ../../modules/features/uni.nix
    ../../modules/features/zram.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # cpu
  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = hostName;
  networking.networkmanager.enable = true;

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
