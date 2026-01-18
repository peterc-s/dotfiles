{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    auto-cpufreq
  ];
  services.auto-cpufreq.enable = true;
}
