{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
  programs.zoxide = {
    enable = true;
    flags = ["--cmd cd"];
  };
}
