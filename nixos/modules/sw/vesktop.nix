{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.vesktop];
  home-manager.users.pete = {
    programs.vesktop = {
      settings = {
        appBadge = false;
        arRPC = true;
        checkUpdates = true;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        splashBackground = "#000000";
        splashColor = "#ffffff";
        splashTheming = false;
        staticTitle = false;
        hardwareAcceleration = false;
        discordBranch = "stable";
      };
    };
  };
}
