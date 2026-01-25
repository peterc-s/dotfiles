{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    anki
    calibre
    obsidian
    zotero
  ];
}
