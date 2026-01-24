{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
  programs.niri.enable = true;
}
