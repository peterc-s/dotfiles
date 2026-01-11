{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/system/audio.nix
    ./modules/system/boot.nix
    ./modules/system/networking.nix
    ./modules/system/locale.nix
    ./modules/system/printing.nix
    ./modules/home/default.nix
    ./modules/software/default.nix
  ];

  nixpkgs.config.allowUnfree = true;


  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };
}
