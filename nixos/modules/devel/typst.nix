{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tinymist
    typst
    typstyle
    websocat
  ];
}
