{
  config,
  pkgs,
  ...
}: {
  xdg.configFile.fish = {
    source = ../../fish;
    recursive = true;
  };

  programs.gpg.publicKeys = {
    source = ../../pubkey.asc;
  };

  home = {
    stateVersion = "25.11";

    file = {
      ".config/sway".source = ../../sway;
      ".config/waybar".source = ../../waybar;
      ".config/rofi".source = ../../rofi;
      ".config/dunst".source = ../../dunst;
      ".config/starship.toml".source = ../../starship/starship.toml;
      ".config/kitty".source = ../../kitty;
      ".config/nvim".source = ../../nvim;
      ".config/satty".source = ../../satty;
      ".config/niri".source = ../../niri;
    };
  };
}
