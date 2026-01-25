{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home-manager.users.pete = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = ../../../noctalia/settings.json;
      colors = ../../../noctalia/colors.json;
      plugins = ../../../noctalia/plugins.json;
    };
  };
}
