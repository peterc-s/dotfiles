{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
  ];
}
