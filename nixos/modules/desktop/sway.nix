{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      wl-clipboard
      wayclip
      slurp
      swayidle
      swaylock-effects
      rofi
      waybar
      wl-mirror
      dunst
      autotiling-rs
    ];
  };
}
