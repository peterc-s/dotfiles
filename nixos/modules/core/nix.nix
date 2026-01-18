{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
  nix.settings.extra-experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
}


