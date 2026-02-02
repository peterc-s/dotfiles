{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (
      ghc.withPackages (
        hsPkgs:
          with hsPkgs; [
            turtle
          ]
      )
    )
  ];
}
