{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    protectKernelImage = true;
    pam.loginLimits = [
      {
        domain = "*"; # all users/sessions
        type = "-"; # both hard/soft
        item = "core";
        value = "0";
      }
    ];
  };
  # environment.memoryAllocator.provider = "graphene-hardened"; # TODO: breaks librewolf
  users.groups.netdev = {};
  services = {
    # dbus.implementation = "broker"; # TODO: breaks something
    gnome.gnome-keyring.enable = true;
    logrotate.enable = true;
    journald = {
      storage = "volatile";
      upload.enable = false;
      extraConfig = ''
        SystemMaxUse=500M
        SystemMaxFileSize=50M
      '';
    };
  };
}
