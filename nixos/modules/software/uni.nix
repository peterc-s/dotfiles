{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./communication/vesktop.nix
  ];

  environment.systemPackages = with pkgs; [
    zotero
    obsidian
  ];
}
