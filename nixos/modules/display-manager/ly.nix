{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:{
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
}

