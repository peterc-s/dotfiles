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
  ];
}
