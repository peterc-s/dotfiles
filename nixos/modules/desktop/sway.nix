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
      satty
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
      nemo
    ];
  };
}
