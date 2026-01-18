{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      extraPackages = with pkgs; [
        SDL2
        gamescope
        er-patcher
      ];
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
