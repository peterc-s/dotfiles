{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  environment.systemPackages = with pkgs; [
    librewolf
  ];

  # use dotfiles
  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: {
    programs.librewolf.profiles.default = {pkgs, ...}: let
      moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
    in {
      id = 0;
      isDefault = true;
      name = "Default";

      extensions = {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = false;
        };

        # bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = moz "bitwarden-password-manager";
          installation_mode = "force_installed";
          updates_disabled = false;
        };
      };
    };
  };
}
