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
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask }:
  let
    configuration = { pkgs, config, ... }: {
      environment.systemPackages = with pkgs; [
	git
	vim
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.caskaydia-cove
      ];

      nix.settings.experimental-features = "nix-command flakes";

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      system.primaryUser = "konrad";

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."Macbook" = nix-darwin.lib.darwinSystem {
      modules = [ 
        ./nix/homebrew.nix
        ./nix/darwin.nix
        configuration
	nix-homebrew.darwinModules.nix-homebrew 
	{
          nix-homebrew = {
            enable = true;
	    enableRosetta = true;
	    user = "konrad";
	    taps = {
              "homebrew/homebrew-core" = homebrew-core;
	      "homebrew/homebrew-cask" = homebrew-cask;
	    };
	    mutableTaps = false;
	  };
	}
	home-manager.darwinModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.users.konrad = import ./nix/home.nix;
	}
      ];
    };
  };
}
