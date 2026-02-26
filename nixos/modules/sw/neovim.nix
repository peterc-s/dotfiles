{
  config,
  lib,
  pkgs,
  inputs,
  pkgs-unstable,
  ...
}: let
  nvim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  programs.neovim = {
    enable = true;
    package = nvim-nightly;
    defaultEditor = true;
  };
}
