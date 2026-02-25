{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  typstPatched = inputs.typst-patched.packages.${pkgs.stdenv.hostPlatform.system}.patched-typst;
in {
  environment.systemPackages = with pkgs; [
    typstPatched
    tinymist
    typstyle
    websocat
  ];
}
