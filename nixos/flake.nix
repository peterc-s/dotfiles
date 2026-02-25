{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    binaryninja = {
      url = "github:jchv/nix-binary-ninja";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    typst-patched = {
      url = "github:peterc-s/typst-patched";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = let
      hostNames = nixpkgs.lib.pipe (builtins.readDir ./hosts) [
        (nixpkgs.lib.filterAttrs (_: type: type == "directory"))
        nixpkgs.lib.attrNames
      ];
    in
      nixpkgs.lib.listToAttrs (map (name: {
          inherit name;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
              (./hosts + "/${name}/configuration.nix")

              home-manager.nixosModules.home-manager
              {
                home-manager.backupFileExtension = "bak";
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.users.pete = import ./home-manager/home.nix;
              }
            ];
          };
        })
        hostNames);
  };
}
