{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./locale.nix
    ./printing.nix
    ./audio.nix
    ./nix.nix
    ./auto-update.nix
    ./fonts.nix
    ./security.nix
  ];
}
