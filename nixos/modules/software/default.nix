{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programming/nix.nix
    ./utils/default.nix
    ./fish.nix
    ./kitty.nix
    ./neovim.nix
    ./librewolf.nix
  ];

  environment.systemPackages = with pkgs; [
    kitty
    yubikey-manager
    starship
    zoxide
    libnotify
    mupdf
    gh
  ];

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        email = "petercs@purelymail.com";
        name = "peterc-s";
      };
    };
  };
}
