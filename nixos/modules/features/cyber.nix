{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    burpsuite
    detect-it-easy
    ghidra
    hexpatch
    seclists
    sleuthkit
    wireshark
  ];
}
