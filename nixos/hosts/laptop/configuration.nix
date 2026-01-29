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

    # development
    ../../modules/devel

    # configured software
    ../../modules/sw/fish.nix
    ../../modules/sw/git.nix
    ../../modules/sw/librewolf.nix
    ../../modules/sw/mullvad.nix
    ../../modules/sw/neovim.nix
    ../../modules/sw/syncthing.nix
    ../../modules/sw/vesktop.nix
    ../../modules/sw/distrobox.nix

    # features
    ../../modules/features/bluetooth.nix
    ../../modules/features/common-software.nix
    ../../modules/features/cyber.nix # must be disabled on install due to binary-ninja
    ../../modules/features/dark-mode.nix
    ../../modules/features/fprint.nix
    ../../modules/features/gaming.nix
    ../../modules/features/power.nix
    ../../modules/features/silly.nix
    ../../modules/features/uni.nix
    ../../modules/features/zram.nix

    # specialisations
    ../../modules/specialisations/nvidia-proprietary.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # cpu
  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = hostName;
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-sstp
      networkmanager-strongswan
      networkmanager-vpnc
    ];
  };

  # users - TODO: i feel like this should be modularise differently to how other things are
  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };

  # system specific packages
  environment.systemPackages = with pkgs; [
    strongswan
    cacert
  ];

  services.strongswan.enable = true;

  environment.etc."strongswan.conf".text = ''
    charon-nm {
      syslog {
          identifier = charon-nm
          daemon {
              default = 1
          }
      }
      plugins {
        eap-mschapv2 {
          load = yes
        }
      }
    }
  '';

  system.stateVersion = "25.11"; # don't change without looking up
}
