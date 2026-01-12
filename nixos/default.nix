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
  nix.settings.extra-experimental-features = ["nix-command" "flakes"];
  environment.localBinInPath = true;

  # fonts
  fonts.packages = with pkgs; [
    meslo-lgs-nf
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];

  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };
}
