{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
  imports = [
    ./zoxide.nix
    ./starship.nix
  ];

  # needed for `sw` and `hms` aliases
  environment.systemPackages = [pkgs.nh];

  programs.fish = let
    flakePath = "~/dotfiles/nixos/";
  in {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      set NH_FLAKE ${flakePath}
    '';
    shellAliases = {
      sw = "NH_OS_FLAKE=${flakePath} nh os switch";
      hms = "NH_HOME_FLAKE=${flakePath} nh home switch";
    };
  };
}
