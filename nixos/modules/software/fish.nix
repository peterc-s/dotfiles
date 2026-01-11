{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  # enable fish, zoxide, starship
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
    '';
  };

  programs.zoxide = {
    enable = true;
    flags = ["--cmd cd"];
  };

  programs.starship.enable = true;

  # fish and starship config
  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    xdg.configFile.fish = {
      source = "${dotfilesDir}/fish";
      recursive = true;
    };

    home.file = {
      ".config/starship.toml".source = "${dotfilesDir}/starship/starship.toml";
    };
  };
}
