{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nix-index-database.nixosModules.default
    {programs.nix-index-database.comma.enable = true;}
  ];

  _module.args.pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
}
