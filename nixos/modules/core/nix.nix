{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  nix.settings.extra-experimental-features = ["nix-command" "flakes"];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nixpkgs.config.allowUnfree = true;
}
