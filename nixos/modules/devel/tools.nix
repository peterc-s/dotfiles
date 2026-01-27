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
    just
    strace
    tree-sitter
    valgrind
  ];
}
