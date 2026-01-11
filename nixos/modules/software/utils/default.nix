{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
  ];
}
