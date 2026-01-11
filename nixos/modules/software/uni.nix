{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./communication/vesktop.nix
    ./programming/latex.nix
    ./programming/typst.nix
  ];

  environment.systemPackages = with pkgs; [
    zotero
    obsidian
  ];
}
