{
  config,
  pkgs,
  ...
}: {
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
    ];
  };
}
