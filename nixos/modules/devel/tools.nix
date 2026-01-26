{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    capstone
    gnumake
    hyperfine
    strace
    tree-sitter
    valgrind
  ];
}
