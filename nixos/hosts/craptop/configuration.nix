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
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  environment.systemPackages = with pkgs; [
    gamemode
    btop
    croc
    home-manager
    kitty
    yubikey-manager
    starship
    zoxide
    libnotify
    mupdf
    gh
    dua
    tealdeer
    tree
    wl-clipboard
    wayclip
    jq
    fzf
    timg
    exiftool
    binwalk
    ripgrep
    file
    gnumake
    gcc
    cmake
    alejandra
    uv
    python3
    ruff
    black
    pylint
    pyright
    ty
    rustup
    bacon
    typst
    typstyle
    tinymist
    websocat
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  system.stateVersion = "25.11"; # don't change without looking up
}
