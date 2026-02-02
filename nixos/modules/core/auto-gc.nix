{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # using nh clean instead of nixos-collect-garbage
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 14d --keep 3";
    };
  };
}
