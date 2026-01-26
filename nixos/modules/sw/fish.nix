{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
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
    # todo: figure out what is removing the them
    interactiveShellInit = ''
      set -U fish_greeting
      fish_config theme choose "fish default"
      set NH_FLAKE ${flakePath}
    '';
    shellAliases = {
      sw = "NH_OS_FLAKE=${flakePath} nh os switch";
    };
  };

  # disable if completion is weird but stops long rebuilds
  documentation.man.generateCaches = false;
}
