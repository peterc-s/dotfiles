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

    # bootloader
    ../../modules/boot/grub.nix
    ../../modules/boot/plymouth.nix

    # dm
    ../../modules/display-manager/ly.nix

    # desktop
    ../../modules/desktop/sway.nix

    # common stuff
    ../../modules/core/core.nix

    # configured software
    ../../modules/sw/git.nix
    ../../modules/sw/fish.nix
    ../../modules/sw/librewolf.nix
    ../../modules/sw/neovim.nix

    # features
    ../../modules/features/gaming.nix
    ../../modules/features/common-software.nix
    ../../modules/features/development.nix
    ../../modules/features/zram.nix
    ../../modules/features/dark-mode.nix
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
