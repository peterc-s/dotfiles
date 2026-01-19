{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    disko,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.craptop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs; inherit pkgs-unstable;};
      modules = [
        disko.nixosModules.disko
        ./hosts/craptop/configuration.nix
        ./hosts/craptop/disk-config.nix
      ];
    };

    homeConfigurations.pete = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [../home-manager/home.nix];
    };
  };
}
