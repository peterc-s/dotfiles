{
  config,
  pkgs,
  ...
}: let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
  dotfilesDir = "${config.home.homeDirectory}/dotfiles";
in {
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    home.stateVersion = "25.11";

    # Use sway config
    xdg.configFile."sway/config".source = "${dotfilesDir}/sway/config";

    xdg.configFile.fish = {
      source = "${dotfilesDir}/fish";
      recursive = true;
    };

    # Other configs
    home.file = {
      ".config/waybar".source = "${dotfilesDir}/waybar";
      ".config/nvim".source = "${dotfilesDir}/nvim";
      ".config/starship.toml".source = "${dotfilesDir}/starship/starship.toml";
    };
  };
}
