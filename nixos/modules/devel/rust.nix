{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bacon
    rust-analyzer
    rustup
  ];
}
