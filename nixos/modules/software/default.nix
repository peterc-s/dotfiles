{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programming/nix.nix
    ./utils/default.nix
  ];

  environment.systemPackages = with pkgs; [
    librewolf
    kitty
    yubikey-manager
    starship
    zoxide
    libnotify
    dunst
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
      diff = {
        tool = "kitty";
        guitool = "kitty.gui";
      };
      difftool = {
        prompt = false;
        trustExitCode = true;
      };
      difftool."kitty" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
      difftool."kitty.gui" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
    };
  };

  # editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
    '';
  };
  programs.zoxide = {
    enable = true;
    flags = ["--cmd cd"];
  };
  programs.starship.enable = true;
}
