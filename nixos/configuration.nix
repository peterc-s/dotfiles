{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # disko
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disk-config.nix
  ];

  # grub
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev";

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # display manager
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

  # desktop
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      slurp
      swayidle
      swaylock-effects
      rofi
      waybar
      wl-mirror
      dunst
      autotiling-rs
    ];
  };

  networking.hostName = "craptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  # locale stuff
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

  console.keyMap = "uk";

  # enable CUPS
  services.printing.enable = true;

  # enable audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  # touchpad support
  services.libinput.enable = true;

  # users
  users.users.pete = {
    isNormalUser = true;
    description = "pete";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
  };

  # nix
  nix.settings.extra-experimental-features = ["nix-command" "flakes"];
  # environment.localBinInPath = true;

  # programs
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    croc
    home-manager
    kitty
    yubikey-manager
    starship
    zoxide
    libnotify
    mupdf
    gh
    dua
    tealdeer
    tree
    wl-clipboard
    wayclip
    jq
    fzf
    timg
    exiftool
    binwalk
    ripgrep
    file
    gnumake
    gcc
    cmake
    alejandra
    uv
    python3
    ruff
    black
    pylint
    pyright
    ty
    rustup
    bacon
    typst
    typstyle
    tinymist
    websocat
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # BitWarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      FirefoxHome = {
        "Search" = false;
      };
      HardwareAcceleration = true;
      Preferences = {
        "browser.preferences.defaultPerformanceSettings.enabled" = false;
        "browser.startup.homepage" = "about:home";
        "browser.toolbar.bookmarks.visibility" = "newtab";
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "places.history.enabled" = "false";
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
      };
    };
  };

  fonts.packages = with pkgs; [
    meslo-lgs-nf
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
  ];

  security.rtkit.enable = true;
  system.copySystemConfiguration = true;

  system.stateVersion = "25.11"; # don't change without looking up
}
