{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.mullvad];
  services.mullvad-vpn.enable = true;
}
