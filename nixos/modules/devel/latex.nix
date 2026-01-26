{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tectonic
    texlivePackages.synctex
  ];
}
