{
  config,
  pkgs,
  ...
}: {
  home = let
    dotfilesDir = "/home/pete/dotfiles";
  in {
    username = "pete";
    homeDirectory = "/home/pete";
    stateVersion = "25.11";

    file = {
      ".config/sway".source = "${dotfilesDir}/sway";
      ".config/fish".source = "${dotfilesDir}/fish";
      ".config/waybar".source = "${dotfilesDir}/waybar";
      ".config/rofi".source = "${dotfilesDir}/rofi";
      ".config/dunst".source = "${dotfilesDir}/dunst";
      ".config/starship.toml".source = "${dotfilesDir}/starship/starship.toml";
      ".config/kitty".source = "${dotfilesDir}/kitty";
      ".config/nvim".source = "${dotfilesDir}/nvim";
    };
  };
}
