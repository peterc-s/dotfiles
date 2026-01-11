{
  config,
  pkgs,
  ...
}: {
  imports = [
    <home-manager/nixos>
  ];

  # set dotfiles directory

  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    home.stateVersion = "25.11";

    xdg.configFile.fish = {
      source = "${dotfilesDir}/fish";
      recursive = true;
    };

    # Other configs
    home.file = {
      ".config/nvim".source = "${dotfilesDir}/nvim";
      ".config/kitty".source = "${dotfilesDir}/kitty";
      ".config/starship.toml".source = "${dotfilesDir}/starship/starship.toml";
    };
  };
}
