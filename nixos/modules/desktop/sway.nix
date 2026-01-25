{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./way-displays.nix];

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
      way-displays
      waybar
      wayclip
      wl-clipboard
      wl-mirror
    ];
  };
}
