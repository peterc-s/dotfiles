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
    wl-mirror
    dunst
    nemo
  ];
  programs.niri.enable = true;
}
