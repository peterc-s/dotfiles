{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false; # fine with proprietary for gaming
  hardware.nvidia.modesetting.enable = true;
  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
