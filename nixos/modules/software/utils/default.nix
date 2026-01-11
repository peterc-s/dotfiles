{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tree
    wl-clipboard
    wayclip
    jq
    fzf
    timg
    exiftool
    binwalk
    ripgrep
  ];
}
