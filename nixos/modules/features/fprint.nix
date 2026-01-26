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
  security.pam.services.login.fprintAuth = false;
  security.pam.services.ly.fprintAuth = false;
  security.pam.services.swaylock.fprintAuth = false;
}
