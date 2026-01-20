{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    }
  ];
  environment.sessionVariables.QT_STYLE_OVERRIDE = "adwaita-dark";
}
