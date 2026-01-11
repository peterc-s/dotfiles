{
  config,
  pkgs,
  ...
}: {
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    home.stateVersion = "25.11";

    services.gnome-keyring.enable = true;
    home.packages = [pkgs.gcr];
  };
}
