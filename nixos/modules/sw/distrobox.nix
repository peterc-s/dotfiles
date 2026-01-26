{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./podman.nix];

  home-manager.users.pete = {
    programs.distrobox = {
      enable = true;
      package = pkgs.distrobox;
      settings = {
        # pass in profile
        container_additional_volumes = "/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro";
        container_manager = "podman";
      };
      containers = {
        arch = {
          additional_packages = "starship";
          image = "docker.io/library/archlinux:latest";
          entry = true;
        };
      };
    };
  };
}
