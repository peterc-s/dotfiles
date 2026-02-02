{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./audio.nix
    ./auto-gc.nix
    ./cpu.nix
    ./fonts.nix
    ./gpg.nix
    ./locale.nix
    ./nix.nix
    ./printing.nix
    ./security.nix
    ./yubikey.nix
  ];
}
