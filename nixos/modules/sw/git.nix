{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
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
        signingkey = "2B4B6F54BED9313D";
      };
      commit.gpgsign = true;
      tag.gpgSign = true;
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
      push = {
        default = "simple";
        recurseSubmodules = "check";
      };
      merge = {
        keepBackup = true;
        autoStash = true;
        ff = "only";
      };
      color = {
        ui = "auto";
        status = "auto";
        branch = "auto";
      };
      pull.rebase = true;
    };
  };
}
