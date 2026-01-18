{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
  fonts.packages = with pkgs; [
    meslo-lgs-nf
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];
}
