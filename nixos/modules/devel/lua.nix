{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lua
    lua-language-server
    lua54Packages.luarocks-nix
    stylua
  ];
}
