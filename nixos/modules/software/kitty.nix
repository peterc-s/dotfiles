{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  environment.systemPackages = with pkgs; [
    kitty
  ];

  # use dotfiles
  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    home.file = {
      ".config/kitty".source = "${dotfilesDir}/kitty";
    };
  };

  # use kitty diff
  programs.git = {
    config = {
      diff = {
        tool = "kitty";
        guitool = "kitty.gui";
      };
      difftool = {
        prompt = false;
        trustExitCode = true;
      };
      difftool."kitty" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
      difftool."kitty.gui" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
    };
  };
}
