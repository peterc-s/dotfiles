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
    xcursor-themes
    adwaita-fonts
    adwaita-icon-theme
  ];
  programs.niri.enable = true;
}
