{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.pete = {
    services.way-displays = {
      enable = true;
      settings = {
        ORDER = [
          "!^DP-"
        ];
        SCALING = false;
        AUTO_SCALE = false;
        MODE = [
          {
            NAME_DESC = "Chimei Innolux Corporation 0x143F (eDP-1)";
            WIDTH = 1920;
            HEIGHT = 1200;
            HZ = 60;
          }
        ];
        VRR_OFF = [
          "Chimei Innolux Corporation 0x143F (eDP-1)"
        ];
      };
    };
  };
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
