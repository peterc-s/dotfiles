{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fprintd
  ];

  services.fprintd.enable = true;
  security.pam.services.sudo = {
    enable = true;
    fprintAuth = true;
  };
}
