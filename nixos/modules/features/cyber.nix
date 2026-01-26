{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # follow the instructions in the binaryninja module
  imports = [../sw/binaryninja.nix];

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
