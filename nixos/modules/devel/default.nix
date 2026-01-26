{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./asm.nix
    ./c.nix
    ./go.nix
    ./js.nix
    ./latex.nix
    ./lua.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./tools.nix
    ./typst.nix
  ];
}
