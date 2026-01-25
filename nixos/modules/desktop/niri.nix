{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    adwaita-fonts
    adwaita-icon-theme
    brightnessctl
    dunst
    grim
    nemo
    rofi
    satty
    slurp
    swayidle
    swaylock-effects
    wayclip
    wl-clipboard
    wl-mirror
    xcursor-themes
    xwayland-satellite
  ];
  programs.niri.enable = true;
}
