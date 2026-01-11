{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    zotero
    obsidian
    vesktop
  ];
}
