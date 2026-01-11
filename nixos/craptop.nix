{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports =
  [
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-b4ab427c-ce0f-4d87-8594-8843e4827865".device = "/dev/disk/by-uuid/b4ab427c-ce0f-4d87-8594-8843e4827865";

  # Networking
  networking.hostName = "craptop";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Use ly
  services.displayManager.ly = {
    enable = true;
    settings = {
      allow_empty_password = true;
      animation = "colormix";
      battery_id = "BAT0";
      bg = "0x00000000";
      box_title = "Lock In";
      clear_password = false;
      colormix_col1 = "0x00282A2E";
      colormix_col2 = "0x00373B41";
      colormix_col3 = "0x00C5C8C6";
      default_input = "password";
      ly_log = "/dev/null";
    };
  };

  # Use sway
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      slurp
      swayidle
      swaylock-effects
      rofi
      wmenu
      waybar
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    rustup
    librewolf
    kitty
    wl-clipboard
    gnumake
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

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


  home-manager.users.pete = { config, pkgs, ... }: {
    home.stateVersion = "25.11";

    # Use sway config
    xdg.configFile."sway/config".source = /home/pete/dotfiles/sway/config;

    # Other configs
    home.file = {
      ".config/waybar".source = ../waybar;
      ".config/nvim".source = ../nvim;
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
