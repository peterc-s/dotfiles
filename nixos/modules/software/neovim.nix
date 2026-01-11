{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # use dotfiles
  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    home.file = {
      ".config/nvim".source = "${dotfilesDir}/nvim";
    };
  };
}
