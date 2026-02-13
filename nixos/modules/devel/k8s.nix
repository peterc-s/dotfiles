{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    k9s
    kubectl
    kubernetes-helm
    opentofu
    tofu-ls
  ];
}
