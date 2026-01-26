{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    black
    pylint
    pyright
    python3
    ruff
    ty
    uv
  ];
}
