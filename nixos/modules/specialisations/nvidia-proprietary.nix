{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  specialisation = {
    nvidia-proprietary = {
      configuration = {
        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia = {
          open = false;
          modesetting.enable = true;
        };
        environment.systemPackages = with pkgs; [
          nvtopPackages.nvidia
          cudatoolkit
        ];
      };
    };
  };
}
