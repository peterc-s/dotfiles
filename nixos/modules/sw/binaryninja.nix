{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.binaryninja.nixosModules.binaryninja
  ];

  # for binary-ninja to work, you must add the installer to the nix-store:
  # nix-store --add-fixed sha256 binaryninja_linux_stable_personal.zip
  programs.binary-ninja = {
    enable = true;
    package = pkgs.binary-ninja-personal-wayland;
  };
}
