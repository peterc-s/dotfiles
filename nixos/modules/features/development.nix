{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    cmake
    alejandra
    uv
    python3
    ruff
    black
    pylint
    pyright
    ty
    rustup
    bacon
    typst
    typstyle
    tinymist
    websocat
  ];
}
