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
      package = pkgs.steam.override {
        extraArgs = "-system-composer";
      };
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
