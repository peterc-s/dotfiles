{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];
  home-manager.users.pete = {pkgs, ...}: {
    programs.vesktop = {
      enable = true;
      settings = {
        checkUpdates = true;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        discordBranch = "stable";
      };
    };
  };
}
