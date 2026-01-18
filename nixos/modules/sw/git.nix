{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
  # for kitten diff
  environment.systemPackages = with pkgs; [kitty];

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
}


