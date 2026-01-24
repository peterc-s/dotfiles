{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

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
