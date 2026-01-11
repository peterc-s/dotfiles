{
  config,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      slurp
      swayidle
      swaylock-effects
      rofi
      waybar
      wl-mirror
      dunst
    ];
  };

  # configure sway, waybar, rofi, and dunst
  home-manager.users.pete = {
    config,
    pkgs,
    ...
  }: let
    dotfilesDir = "${config.home.homeDirectory}/dotfiles";
  in {
    xdg.configFile."sway/config".source = "${dotfilesDir}/sway/config";
    home.file = {
      ".config/waybar".source = "${dotfilesDir}/waybar";
      ".config/rofi".source = "${dotfilesDir}/rofi";
      ".config/dunst".source = "${dotfilesDir}/dunst";
    };
  };
}
