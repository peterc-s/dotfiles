{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./audio.nix
    ./auto-update.nix
    ./cpu.nix
    ./fonts.nix
    ./locale.nix
    ./nix.nix
    ./printing.nix
    ./security.nix
  ];
}
