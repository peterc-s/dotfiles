{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    capstone
    direnv
    gnumake
    hyperfine
    just
    strace
    tree-sitter
    valgrind
  ];
}
