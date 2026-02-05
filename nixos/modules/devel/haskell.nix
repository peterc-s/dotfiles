{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ormolu
    haskell-language-server
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
