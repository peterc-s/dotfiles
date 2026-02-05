{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bacon
    cargo-msrv
    rust-analyzer
    rustup
  ];
}
