{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./default.nix

    # system
    ./modules/system/auto-update.nix

    # graphical environment
    ./modules/display-manager/ly.nix
    ./modules/desktop/sway.nix

    # programming
    ./modules/software/programming/c.nix
    ./modules/software/programming/rust.nix
    ./modules/software/programming/python.nix
  ];

  # device specific stuff
  boot.initrd.luks.devices."luks-b4ab427c-ce0f-4d87-8594-8843e4827865".device = "/dev/disk/by-uuid/b4ab427c-ce0f-4d87-8594-8843e4827865";
  networking.hostName = "craptop";
  services.libinput.enable = true; # enable touchpad support
  services.mullvad-vpn.enable = true;

  system.stateVersion = "25.11"; # read https://nixos.org/nixos/options.html
}
