{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  hardware.bluetooth.enable = true;
  environment.systemPackages = [pkgs.bluetui];
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}
