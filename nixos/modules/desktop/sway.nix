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
      autotiling-rs
      brightnessctl
      dunst
      grim
      nemo
      rofi
      satty
      slurp
      swayidle
      swaylock-effects
      waybar
      wayclip
      wl-clipboard
      wl-mirror
    ];
  };
}
