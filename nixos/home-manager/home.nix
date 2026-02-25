{
  config,
  lib,
  pkgs,
  ...
}: let
  symlinkRoot = "/home/pete/dotfiles";

  # most of this is from https://blog.daniel-beskin.com/2025-10-18-symlinking-home-manager#user-content-fn-tweak
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) flatten flip map mapAttrsToList mergeAttrsList;

  pipe = flip lib.pipe;
  flatMerge = pipe [flatten mergeAttrsList];

  toSrcFile = name: "${symlinkRoot}/${name}";
  link = pipe [toSrcFile mkOutOfStoreSymlink];

  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  linkMappedFiles = attrs: mapAttrsToList (dest: src: {${dest}.source = link src;}) attrs;
  linkConfDirs = map linkDir;

  confDirs = linkConfDirs [
    "dunst"
    "fish"
    "kitty"
    "niri"
    "nvim"
    "rofi"
    "satty"
    "sway"
    "waybar"
  ];

  confFiles = linkMappedFiles {
    "starship.toml" = "starship/starship.toml";
  };

  links = flatMerge [confDirs confFiles];
in {
  xdg.configFile = links;

  programs.gpg = {
    scdaemonSettings.disable-ccid = true;
    publicKeys = {
      source = ../../pubkey.asc;
    };
  };

  home.stateVersion = "25.11";
}
