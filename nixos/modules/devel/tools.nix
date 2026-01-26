{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    capstone
    distrobox # todo: move to modules/sw/distrobox.nix and configure
    gnumake
    hyperfine
    strace
    tree-sitter
    valgrind
  ];
}
