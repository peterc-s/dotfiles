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
  ];

  environment.systemPackages = with pkgs; [
    librewolf
    kitty
    yubikey-manager
    starship
    zoxide
    libnotify
    mupdf
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
