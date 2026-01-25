{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.pete.home.file.".config/way-displays".source = ../../../way-displays;
}
