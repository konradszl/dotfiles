{
  description = "Konrad's Nix configuration.";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-functions = {
      url = "github:Azure/homebrew-functions";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-functions,
    }:
    {
      darwinConfigurations."MacBook" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./nix/homebrew.nix
          ./nix/darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "konrad";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "azure/homebrew-functions" = homebrew-functions;
              };
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.konrad.imports = [
              ./nix/home
              ./nix/home/darwin.nix
            ];
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      nixosConfigurations."ThinkPad" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          ./nix/nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.konrad.imports = [
              ./nix/home
              ./nix/home/nixos.nix
            ];
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-tree;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
