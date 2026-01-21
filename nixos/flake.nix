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
    nixosConfigurations = {
      "craptop" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };
        modules = [
          disko.nixosModules.disko
          ./hosts/craptop/configuration.nix

          # bootloader
          ./modules/boot/grub.nix
          ./modules/boot/plymouth.nix

          # dm
          ./modules/display-manager/ly.nix

          # desktop
          ./modules/desktop/sway.nix

          # common stuff
          ./modules/core/core.nix

          # configured software
          ./modules/sw/git.nix
          ./modules/sw/fish.nix
          ./modules/sw/librewolf.nix
          ./modules/sw/neovim.nix

          # features
          ./modules/features/gaming.nix
          ./modules/features/common-software.nix
          ./modules/features/development.nix
          ./modules/features/zram.nix
          ./modules/features/dark-mode.nix
        ];
      };
    };
    homeConfigurations.pete = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [../home-manager/home.nix];
    };
  };
}
